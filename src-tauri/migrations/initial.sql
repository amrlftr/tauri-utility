-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS "menus";
CREATE TABLE "menus" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" TEXT,
  "title" TEXT,
  "subtitle" TEXT,
  "is_active" integer
);

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO "menus" VALUES (1, 'text', 'Text Manipulation', 'Convert to text case and extract details', 1);
INSERT INTO "menus" VALUES (2, 'mutator', 'Duplication Mutator', 'Morph string element into specialized template', 1);
INSERT INTO "menus" VALUES (3, 'query', 'Query Builder', 'Generate query statement', 0);
INSERT INTO "menus" VALUES (4, 'notes', 'Quick Notes', 'Jotting multiple transient notes in one place', 1);
INSERT INTO "menus" VALUES (5, 'tasks', 'Task Management', 'Manage all upcoming and in progress tasks', 0);
INSERT INTO "menus" VALUES (6, 'daily-tracker', 'Daily Tracker', 'Keep track of all your daily goals', 1);
INSERT INTO "menus" VALUES (7, 'diagram', 'Diagram', 'Create dynamic data visualization using text definitions', 1);

-- ----------------------------
-- Table structure for mutator_templates
-- ----------------------------
DROP TABLE IF EXISTS "mutator_templates";
CREATE TABLE "mutator_templates" (
  "id" INTEGER NOT NULL,
  "title" TEXT,
  "code" TEXT,
  "type" TEXT NOT NULL,
  "is_default" integer,
  PRIMARY KEY ("id")
);

-- ----------------------------
-- Records of mutator_templates
-- ----------------------------
INSERT INTO "mutator_templates" VALUES (1, 'console.log', 'console.log({x});', 'single', 1);
INSERT INTO "mutator_templates" VALUES (2, 'String - migrations', "$table->string('{x}', 50)->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (3, 'Integer - migrations', "$table->integer('{x}')->unsigned()->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (4, 'Float - migrations', "$table->float('{x}', 7, 2)->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (5, 'Decimal - migrations', "$table->decimal('{x}', 6, 2)->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (6, 'Boolean - migrations', "$table->boolean('{x}')->default(0);", 'single', 0);
INSERT INTO "mutator_templates" VALUES (7, 'Date - migrations', "$table->date('{x}')->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (8, 'Date - migrations', "$table->time('{x}')->nullable();", 'single', 0);
INSERT INTO "mutator_templates" VALUES (9, 'String - validation', "'{x}' => 'required|string',", 'single', 0);
INSERT INTO "mutator_templates" VALUES (10, 'Unique - validation', "'{x}' => 'required|string|unique:users',", 'single', 0);
INSERT INTO "mutator_templates" VALUES (11, 'Array - validation', "'{x}' => 'required|array|min:1',", 'single', 0);
INSERT INTO "mutator_templates" VALUES (12, 'Default - crud', "'{x}' => $request->{x},", 'single', 0);
INSERT INTO "mutator_templates" VALUES (13, 'Password - crud', "'{x}' => Hash::make($request->{x}),", 'single', 0);
INSERT INTO "mutator_templates" VALUES (14, 'Array to String - crud', "'{x}' => implode($request->{x},','),", 'single', 0);
INSERT INTO "mutator_templates" VALUES (15, 'console.log', 'console.log({x1});', 'multiple', 1);

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS "tasks";
CREATE TABLE "tasks" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" TEXT,
  "desc" TEXT,
  "status" TEXT,
  "priority" TEXT,
  "due_date" TEXT
);

-- ----------------------------
-- Table structure for task_todos
-- ----------------------------
DROP TABLE IF EXISTS "task_todos";
CREATE TABLE "task_todos" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" TEXT,
  "is_done" integer,
  "task_id" INTEGER
);
