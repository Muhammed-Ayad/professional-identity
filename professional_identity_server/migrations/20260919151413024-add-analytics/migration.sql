BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile_analytics_event" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "eventType" text NOT NULL,
    "target" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "profile_analytics_profile_id_idx" ON "profile_analytics_event" USING btree ("profileId");
CREATE INDEX "profile_analytics_profile_type_idx" ON "profile_analytics_event" USING btree ("profileId", "eventType");
CREATE INDEX "profile_analytics_profile_created_idx" ON "profile_analytics_event" USING btree ("profileId", "createdAt");
CREATE INDEX "profile_analytics_profile_type_created_idx" ON "profile_analytics_event" USING btree ("profileId", "eventType", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "profile_analytics_event"
    ADD CONSTRAINT "profile_analytics_event_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919151413024-add-analytics', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919151413024-add-analytics', "timestamp" = now();

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
