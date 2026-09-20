BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "handle" text NOT NULL,
    "fullName" text NOT NULL,
    "headline" text,
    "bio" text,
    "location" text,
    "currentRole" text,
    "yearsOfExperience" bigint,
    "availability" text,
    "contactEmail" text,
    "websiteUrl" text,
    "avatarUrl" text,
    "cvUrl" text,
    "isPublic" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "profile_handle_idx" ON "profile" USING btree ("handle");
CREATE UNIQUE INDEX "profile_auth_user_id_idx" ON "profile" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "profile"
    ADD CONSTRAINT "profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919124213810-add-profile', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919124213810-add-profile', "timestamp" = now();

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
