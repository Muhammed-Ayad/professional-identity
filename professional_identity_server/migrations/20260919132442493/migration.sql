BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "role" text,
    "url" text,
    "repositoryUrl" text,
    "imageUrl" text,
    "technologies" json NOT NULL,
    "startDate" timestamp without time zone,
    "endDate" timestamp without time zone,
    "isOngoing" boolean NOT NULL DEFAULT false,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "project_profile_id_idx" ON "project" USING btree ("profileId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "project"
    ADD CONSTRAINT "project_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919132442493', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919132442493', "timestamp" = now();

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
