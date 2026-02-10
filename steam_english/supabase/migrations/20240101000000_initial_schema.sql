-- Enable necessary extensions
create extension if not exists pgcrypto;

-- -----------------------------------------------------------------------------
-- 1. Schools & Users
-- -----------------------------------------------------------------------------

-- Schools
create table public.schools (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

-- Profiles (extends auth.users)
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  school_id uuid not null references public.schools(id) on delete cascade,
  role text not null check (role in ('student','teacher','admin')),
  full_name text not null,
  email text not null,
  created_at timestamptz not null default now()
);

create index on public.profiles(school_id);
create index on public.profiles(role);

-- -----------------------------------------------------------------------------
-- 2. Lesson Groups
-- -----------------------------------------------------------------------------

create table public.lesson_groups (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  teacher_id uuid not null references public.profiles(id) on delete restrict,
  name text not null,
  level text,
  goal text,
  created_at timestamptz not null default now()
);

create index on public.lesson_groups(school_id);
create index on public.lesson_groups(teacher_id);

create table public.lesson_group_members (
  id uuid primary key default gen_random_uuid(),
  lesson_group_id uuid not null references public.lesson_groups(id) on delete cascade,
  student_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique(lesson_group_id, student_id)
);

create index on public.lesson_group_members(lesson_group_id);
create index on public.lesson_group_members(student_id);

-- -----------------------------------------------------------------------------
-- 3. Content: Tracks & Lessons
-- -----------------------------------------------------------------------------

create table public.tracks (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  title text not null,
  type text not null check (type in ('phonetics','vocab','structures','exercises')),
  created_at timestamptz not null default now()
);

create table public.lessons (
  id uuid primary key default gen_random_uuid(),
  track_id uuid not null references public.tracks(id) on delete cascade,
  title text not null,
  level text,
  content_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index on public.lessons(track_id);

-- Assignments
create table public.lesson_assignments (
  id uuid primary key default gen_random_uuid(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  lesson_group_id uuid not null references public.lesson_groups(id) on delete cascade,
  due_date timestamptz,
  created_at timestamptz not null default now(),
  unique(lesson_id, lesson_group_id)
);

-- Attempts
create table public.lesson_attempts (
  id uuid primary key default gen_random_uuid(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  student_id uuid not null references public.profiles(id) on delete cascade,
  score numeric,
  time_spent_sec int,
  answers_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index on public.lesson_attempts(student_id, created_at);

-- -----------------------------------------------------------------------------
-- 4. Pronunciation
-- -----------------------------------------------------------------------------

create table public.pronunciation_prompts (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  text text not null,
  level text,
  tags text[],
  created_at timestamptz not null default now()
);

create table public.pronunciation_attempts (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.profiles(id) on delete cascade,
  prompt_id uuid references public.pronunciation_prompts(id) on delete set null,
  target_text text not null,
  transcript text,
  accuracy_score numeric,
  audio_path text,
  meta_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index on public.pronunciation_attempts(student_id, created_at);

-- -----------------------------------------------------------------------------
-- 5. Projects (PBL)
-- -----------------------------------------------------------------------------

create table public.projects (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  teacher_id uuid not null references public.profiles(id) on delete restrict,
  lesson_group_id uuid not null references public.lesson_groups(id) on delete cascade,
  title text not null,
  description text,
  objectives text,
  rubric_json jsonb not null default '{}'::jsonb,
  due_date timestamptz,
  attachments_json jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

create index on public.projects(lesson_group_id, due_date);

create table public.project_submissions (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  student_id uuid not null references public.profiles(id) on delete cascade,
  submission_type text not null check (submission_type in ('link','file','audio','video')),
  submission_url_or_path text not null,
  notes text,
  status text not null default 'submitted'
    check (status in ('submitted','reviewed','needs_revision','approved')),
  created_at timestamptz not null default now()
);

create index on public.project_submissions(project_id, created_at);
create index on public.project_submissions(student_id, created_at);

create table public.project_reviews (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references public.project_submissions(id) on delete cascade,
  teacher_id uuid not null references public.profiles(id) on delete restrict,
  grade numeric,
  feedback text,
  rubric_result_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index on public.project_reviews(submission_id);


-- -----------------------------------------------------------------------------
-- ROW LEVEL SECURITY (RLS) POLICIES
-- -----------------------------------------------------------------------------

alter table public.schools enable row level security;
alter table public.profiles enable row level security;
alter table public.lesson_groups enable row level security;
alter table public.lesson_group_members enable row level security;
alter table public.tracks enable row level security;
alter table public.lessons enable row level security;
alter table public.lesson_assignments enable row level security;
alter table public.lesson_attempts enable row level security;
alter table public.pronunciation_prompts enable row level security;
alter table public.pronunciation_attempts enable row level security;
alter table public.projects enable row level security;
alter table public.project_submissions enable row level security;
alter table public.project_reviews enable row level security;

-- -----------------------------------------------------------------------------
-- RLS HELPERS
-- -----------------------------------------------------------------------------

create or replace function public.current_profile()
returns public.profiles
language sql stable as $$
  select * from public.profiles where id = auth.uid()
$$;

create or replace function public.is_admin()
returns boolean language sql stable as $$
  select (select role from public.profiles where id = auth.uid()) = 'admin'
$$;

create or replace function public.is_teacher()
returns boolean language sql stable as $$
  select (select role from public.profiles where id = auth.uid()) = 'teacher'
$$;

create or replace function public.is_student()
returns boolean language sql stable as $$
  select (select role from public.profiles where id = auth.uid()) = 'student'
$$;

create or replace function public.same_school(target_school uuid)
returns boolean language sql stable as $$
  select (select school_id from public.profiles where id = auth.uid()) = target_school
$$;

-- -----------------------------------------------------------------------------
-- POLICIES
-- -----------------------------------------------------------------------------

-- 1. Profiles
create policy "profiles_select_self"
  on public.profiles for select
  using (id = auth.uid());

create policy "profiles_select_admin_school"
  on public.profiles for select
  using (public.is_admin() and public.same_school(school_id));

create policy "profiles_update_self"
  on public.profiles for update
  using (id = auth.uid());

-- 2. Lesson Groups
create policy "groups_select_teacher"
  on public.lesson_groups for select
  using (public.is_teacher() and teacher_id = auth.uid());

create policy "groups_select_student_member"
  on public.lesson_groups for select
  using (
    public.is_student()
    and exists (
      select 1
      from public.lesson_group_members m
      where m.lesson_group_id = lesson_groups.id
        and m.student_id = auth.uid()
    )
  );

create policy "groups_select_admin"
  on public.lesson_groups for select
  using (public.is_admin() and public.same_school(school_id));

create policy "groups_insert_teacher"
  on public.lesson_groups for insert
  with check (
    public.is_teacher()
    and teacher_id = auth.uid()
    and public.same_school(school_id)
  );
  
-- Also allow admin to insert/manage?
create policy "groups_all_admin"
  on public.lesson_groups for all
  using (public.is_admin() and public.same_school(school_id));


-- 3. Lesson Group Members
-- Teacher gerencia membros do próprio grupo
create policy "members_teacher_manage"
on public.lesson_group_members for all
using (
  public.is_teacher()
  and exists (
    select 1 from public.lesson_groups g
    where g.id = lesson_group_members.lesson_group_id
      and g.teacher_id = auth.uid()
  )
)
with check (
  public.is_teacher()
  and exists (
    select 1 from public.lesson_groups g
    where g.id = lesson_group_members.lesson_group_id
      and g.teacher_id = auth.uid()
  )
);

-- Student vê memberships dele
create policy "members_student_select_self"
on public.lesson_group_members for select
using (public.is_student() and student_id = auth.uid());

-- Admin vê tudo da escola (via join)
create policy "members_admin_select"
on public.lesson_group_members for select
using (
  public.is_admin()
  and exists (
    select 1
    from public.lesson_groups g
    where g.id = lesson_group_members.lesson_group_id
      and public.same_school(g.school_id)
  )
);


-- 4. Content (Tracks & Lessons)
-- Readable by school. Editable by Teachers/Admins.
create policy "tracks_select_school"
  on public.tracks for select
  using (public.same_school(school_id));

create policy "tracks_all_teacher_admin"
  on public.tracks for all
  using ( (public.is_teacher() or public.is_admin()) and public.same_school(school_id) );

create policy "lessons_select_school"
  on public.lessons for select
  using (
    exists (
      select 1 from public.tracks 
      where id = track_id 
      and public.same_school(school_id)
    )
  );

create policy "lessons_all_teacher_admin"
  on public.lessons for all
  using (
    exists (
      select 1 from public.tracks 
      where id = track_id 
      and public.same_school(school_id)
    )
    and (public.is_teacher() or public.is_admin())
  );

-- 5. Assignments
create policy "assignments_select_member"
  on public.lesson_assignments for select
  using (
    exists (
      select 1 from public.lesson_group_members
      where lesson_group_id = public.lesson_assignments.lesson_group_id
      and student_id = auth.uid()
    )
    or
    exists (
      select 1 from public.lesson_groups
      where id = public.lesson_assignments.lesson_group_id
      and teacher_id = auth.uid()
    )
  );
  
create policy "assignments_all_teacher"
  on public.lesson_assignments for all
  using (
    public.is_teacher() and exists (
      select 1 from public.lesson_groups
      where id = lesson_group_id
      and teacher_id = auth.uid()
    )
  );

-- 6. Pronunciation Prompts
create policy "prompts_select_school"
  on public.pronunciation_prompts for select
  using ( public.same_school(school_id) );

-- 7. Pronunciation Attempts
create policy "attempts_all_student_owner"
  on public.pronunciation_attempts for all
  using ( public.is_student() and student_id = auth.uid() );

create policy "attempts_select_teacher_group"
  on public.pronunciation_attempts for select
  using (
    public.is_teacher() and exists (
      select 1 from public.lesson_group_members m
      join public.lesson_groups g on m.lesson_group_id = g.id
      where m.student_id = public.pronunciation_attempts.student_id
      and g.teacher_id = auth.uid()
    )
  );

-- 8. Projects (PBL)
create policy "projects_all_teacher_owner"
  on public.projects for all
  using ( public.is_teacher() and teacher_id = auth.uid() );

create policy "projects_select_student_assigned"
  on public.projects for select
  using (
    public.is_student() and exists (
      select 1 from public.lesson_group_members
      where lesson_group_id = public.projects.lesson_group_id
      and student_id = auth.uid()
    )
  );

-- 9. Project Submissions
create policy "submissions_all_student_owner"
  on public.project_submissions for all
  using ( public.is_student() and student_id = auth.uid() );

create policy "submissions_select_teacher_project_owner"
  on public.project_submissions for select
  using (
    public.is_teacher() and exists (
      select 1 from public.projects
      where id = project_id
      and teacher_id = auth.uid()
    )
  );

-- 10. Project Reviews
create policy "reviews_all_teacher_owner"
  on public.project_reviews for all
  using ( public.is_teacher() and teacher_id = auth.uid() );

create policy "reviews_select_student_submission_owner"
  on public.project_reviews for select
  using (
    public.is_student() and exists (
      select 1 from public.project_submissions
      where id = submission_id
      and student_id = auth.uid()
    )
  );
