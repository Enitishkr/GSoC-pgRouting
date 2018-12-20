\i setup.sql

SELECT plan(5);

----------------------------------
-- tests for all
-- prefix:  pgr_extractvertices
----------------------------------

SELECT has_function('pgr_extractvertices');
SELECT has_function('pgr_extractvertices',    ARRAY['text']);
SELECT function_returns('pgr_extractvertices', ARRAY['text'], 'setof record');

-- pgr_extractvertices
-- parameter names
SELECT set_eq(
    $$SELECT  proargnames from pg_proc where proname = 'pgr_extractvertices'$$,
    $$SELECT  '{"","id","x","y","the_geom"}'::TEXT[] $$
);

PREPARE fn_types AS
SELECT ARRAY[25,20,701,701,oid] FROM pg_type WHERE typname = 'geometry';

-- parameter types
SELECT set_eq(
    $$SELECT  proallargtypes from pg_proc where proname = 'pgr_extractvertices'$$,
    $$fn_types$$
);


SELECT * FROM finish();
ROLLBACK;