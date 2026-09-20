BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "experience" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "company" text NOT NULL,
    "jobTitle" text NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone,
    "isCurrent" boolean NOT NULL DEFAULT false,
    "description" text,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "experience_profile_id_idx" ON "experience" USING btree ("profileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "skill" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "name" text NOT NULL,
    "category" text,
    "yearsOfExperience" bigint,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "skill_profile_id_idx" ON "skill" USING btree ("profileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "social_link" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "platform" text NOT NULL,
    "url" text NOT NULL,
    "label" text,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "social_link_profile_id_idx" ON "social_link" USING btree ("profileId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "experience"
    ADD CONSTRAINT "experience_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "skill"
    ADD CONSTRAINT "skill_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "social_link"
    ADD CONSTRAINT "social_link_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919125629122-add-phase2-tables', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919125629122-add-phase2-tables', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
