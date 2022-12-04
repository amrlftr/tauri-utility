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
INSERT INTO "menus" VALUES (6, 'daily-tracker', 'Daily Tracker', 'Keep track of all your daily goals', 1);
