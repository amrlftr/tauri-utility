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
INSERT INTO "menus" VALUES (5, 'tasks', 'Task Management', 'Manage all upcoming and in progress tasks', 1);
INSERT INTO "menus" VALUES (6, 'daily-tracker', 'Daily Tracker', 'Keep track of all your daily goals', 0);
INSERT INTO "menus" VALUES (7, 'diagram', 'Diagram', 'Create dynamic data visualization using text definitions', 1);

-- ----------------------------
-- Table structure for mutator_templates
-- ----------------------------
DROP TABLE IF EXISTS "mutator_templates";
CREATE TABLE "mutator_templates" (
  "id" INTEGER NOT NULL,
  "code" TEXT,
  "type" TEXT NOT NULL,
  "is_default" integer,
  PRIMARY KEY ("id")
);

-- ----------------------------
-- Records of mutator_templates
-- ----------------------------
INSERT INTO "mutator_templates" VALUES (1, 'console.log({x});', 'single', 1);
INSERT INTO "mutator_templates" VALUES (2, '{x} => $request->{x},', 'single', 0);
INSERT INTO "mutator_templates" VALUES (3, '$table->string(''{x}'')->nullable();', 'single', 0);
INSERT INTO "mutator_templates" VALUES (4, '''{x}'' => ''required|string'',', 'single', 0);
INSERT INTO "mutator_templates" VALUES (5, 'console.log({x1});', 'multiple', 0);

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
