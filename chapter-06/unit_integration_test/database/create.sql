drop schema tests cascade;
create schema tests;

create table tests.enrollment (
    id_enrollment integer,
    student_name text,
    course_code text,
    average numeric
);

create table tests.grade (
    id_grade integer,
    id_enrollment integer,
    exam_code text,
    value numeric,
    weight numeric,
);

insert into tests.enrollment (id_enrollment, student_name, course_code, average) values (1, 'Felipe Sales', 'WAYER_X', 0);
insert into tests.grade (id_grade, id_enrollment, exam_code, value, weight) values (1, 1, 'W1', 10, 0.3);
insert into tests.grade (id_grade, id_enrollment, exam_code, value, weight) values (2, 1, 'W2', 9, 0.3);
insert into tests.grade (id_grade, id_enrollment, exam_code, value, weight) values (3, 1, 'W3', 8, 0.4);
