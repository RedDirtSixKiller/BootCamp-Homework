

CREATE TABLE "permits_main" (
    "id" int   NOT NULL,
    "permit_number" varchar   NOT NULL,
    "permit_type" int   NOT NULL,
    "block" int   NOT NULL,
    "lot" int   NOT NULL,
    "street_number" int   NOT NULL,
    "street_numb_suffix" int   NOT NULL,
    "street_name" int   NOT NULL,
    "street_suffix" int   NOT NULL,
    "current_status" in   NOT NULL,
    "current_status_date" date   NOT NULL,
    "filed_date" date   NOT NULL,
    "issued_date" date   NOT NULL,
    "complete_date" date   NOT NULL,
    "first_cons_doc_date" date   NOT NULL,
    "structural_notif" bool   NOT NULL,
    "existing_stories" int   NOT NULL,
    "proposed_stories" int   NOT NULL,
    "fire_permit_only" bool   NOT NULL,
    "permit_expiration_date" date   NOT NULL,
    "est_cost" int   NOT NULL,
    "revised_cost" int   NOT NULL,
    "existing_use" int   NOT NULL,
    "proposed_use" int   NOT NULL,
    "existing_cons_type" int   NOT NULL,
    "proposed_cons_type" int   NOT NULL,
    "site_permit" bool   NOT NULL,
    "sup_dist" int   NOT NULL,
    "neighborhood" int   NOT NULL,
    "zip" int   NOT NULL,
    "latitude" double   NOT NULL,
    "longitude" double   NOT NULL,
    CONSTRAINT "pk_permits_main" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "patron_main" (
    "id" int   NOT NULL,
    "patron_type" iint   NOT NULL,
    "reg_year" int   NOT NULL,
    "sup_dist" int   NOT NULL,
    "patron_age" int   NOT NULL,
    "home_lib" int   NOT NULL,
    "circ_month" int   NOT NULL,
    "circ_year" int   NOT NULL,
    "provided_email" bool   NOT NULL,
    "notice_pref" int   NOT NULL,
    "total_checkouts" int   NOT NULL,
    "total_renewals" int   NOT NULL,
    "outside_county" bool   NOT NULL,
    CONSTRAINT "pk_patron_main" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_patron_type" (
    "id" int   NOT NULL,
    "patron_type_def" varchar   NOT NULL,
    CONSTRAINT "pk_ref_patron_type" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_age_range" (
    "id" int   NOT NULL,
    "range" varchar   NOT NULL,
    CONSTRAINT "pk_ref_age_range" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_lib_code" (
    "id" int   NOT NULL,
    "lib_code" varchar   NOT NULL,
    "lin_def" varchar   NOT NULL,
    CONSTRAINT "pk_ref_lib_code" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_notice" (
    "id" int   NOT NULL,
    "notice_cd" varchar   NOT NULL,
    "notice_def" varchar   NOT NULL,
    CONSTRAINT "pk_ref_notice" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_supervisor" (
    "id" int   NOT NULL,
    "sup_dist" int   NOT NULL,
    CONSTRAINT "pk_ref_supervisor" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_c_month" (
    "id" int   NOT NULL,
    "month" varchar   NOT NULL,
    CONSTRAINT "pk_ref_c_month" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_c_year" (
    "id" int   NOT NULL,
    "year" int   NOT NULL,
    CONSTRAINT "pk_ref_c_year" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "ref_street_suffix" (
    "id" int   NOT NULL,
    "suffix" varchar   NOT NULL,
    CONSTRAINT "pk_ref_street_suffix" PRIMARY KEY (
        "id"
     )
);

-- Free plan table limit reached. SUBSCRIBE for more.



ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_permit_type" FOREIGN KEY("permit_type")
REFERENCES "ref_permit_type" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_block" FOREIGN KEY("block")
REFERENCES "ref_block" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_lot" FOREIGN KEY("lot")
REFERENCES "ref_lot" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_street_numb_suffix" FOREIGN KEY("street_numb_suffix")
REFERENCES "ref_street_numb_suf" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_street_name" FOREIGN KEY("street_name")
REFERENCES "ref_street_name" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_street_suffix" FOREIGN KEY("street_suffix")
REFERENCES "ref_street_suffix" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_current_status" FOREIGN KEY("current_status")
REFERENCES "ref_status" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_existing_use" FOREIGN KEY("existing_use")
REFERENCES "ref_use" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_proposed_use" FOREIGN KEY("proposed_use")
REFERENCES "ref_use" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_existing_cons_type" FOREIGN KEY("existing_cons_type")
REFERENCES "ref_cons_type" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_proposed_cons_type" FOREIGN KEY("proposed_cons_type")
REFERENCES "ref_cons_type" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_sup_dist" FOREIGN KEY("sup_dist")
REFERENCES "ref_supervisor" ("id");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_neighborhood" FOREIGN KEY("neighborhood")
REFERENCES "Table 19" ("...");

ALTER TABLE "permits_main" ADD CONSTRAINT "fk_permits_main_zip" FOREIGN KEY("zip")
REFERENCES "Table 20" ("...");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_patron_type" FOREIGN KEY("patron_type")
REFERENCES "ref_patron_type" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_reg_year" FOREIGN KEY("reg_year")
REFERENCES "ref_c_year" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_sup_dist" FOREIGN KEY("sup_dist")
REFERENCES "ref_supervisor" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_patron_age" FOREIGN KEY("patron_age")
REFERENCES "ref_age_range" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_home_lib" FOREIGN KEY("home_lib")
REFERENCES "ref_lib_code" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_circ_month" FOREIGN KEY("circ_month")
REFERENCES "ref_c_month" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_circ_year" FOREIGN KEY("circ_year")
REFERENCES "ref_c_year" ("id");

ALTER TABLE "patron_main" ADD CONSTRAINT "fk_patron_main_notice_pref" FOREIGN KEY("notice_pref")
REFERENCES "ref_notice" ("id");


