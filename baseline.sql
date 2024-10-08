CREATE SCHEMA IF NOT EXISTS app;
ALTER schema app OWNER TO "demouser";

CREATE SCHEMA IF NOT EXISTS acl;
ALTER schema acl OWNER TO "demouser";

CREATE SCHEMA IF NOT EXISTS auth;
ALTER schema auth OWNER TO "demouser";

CREATE SCHEMA IF NOT EXISTS vfs;
ALTER schema vfs OWNER TO "demouser";

CREATE SCHEMA IF NOT EXISTS core_web;
ALTER schema core_web OWNER TO "demouser";

CREATE SCHEMA IF NOT EXISTS messaging;
ALTER schema messaging OWNER TO "demouser";

-- New Migration
create table acl.ac_validation_tokens
(
    id                bigserial    not null,
    created_at        timestamp    not null,
    created_by        varchar(255),
    deleted           boolean      not null,
    updated_at        timestamp,
    updated_by        varchar(255),
    uuid_str          varchar(255) not null,
    token             varchar(255),
    token_valid       boolean      not null,
    token_valid_until timestamp,
    reason            varchar(255),
    username          varchar(255),
    user_id           int8,
    primary key (id)
);
alter table if exists acl.ac_validation_tokens
    add constraint UK_e4b8maumvhg565vctf1au3so2 unique (uuid_str);
create table app.profiles
(
    id                 bigserial    not null,
    created_at         timestamp    not null,
    created_by         varchar(255),
    deleted            boolean      not null,
    updated_at         timestamp,
    updated_by         varchar(255),
    uuid_str           varchar(255) not null,
    age                varchar(255),
    birthday           timestamp    not null,
    blood_group        varchar(255),
    gender             varchar(255),
    name               varchar(255),
    photo              varchar(255),
    photo_identity_url varchar(255),
    address_id         int8,
    user_id            int8,
    primary key (id)
);
create table app.promotions
(
    id               bigserial    not null,
    created_at       timestamp    not null,
    created_by       varchar(255),
    deleted          boolean      not null,
    updated_at       timestamp,
    updated_by       varchar(255),
    uuid_str         varchar(255) not null,
    active           boolean      not null,
    background_color varchar(255),
    click_count      int8         not null,
    description      varchar(2000),
    priority         varchar(255),
    promo_image      varchar(255),
    text_color       varchar(255),
    title            varchar(255) not null,
    url              varchar(255),
    view_count       int8         not null,
    primary key (id)
);
alter table if exists app.profiles
    add constraint UK_m08m124r50l5jc9uoepqb3ves unique (uuid_str);
alter table if exists app.promotions
    add constraint UK_5kbg11yrptyiaukp1u9ox74eq unique (uuid_str);
create table auth.m_users
(
    id                      bigserial    not null,
    created_at              timestamp    not null,
    created_by              varchar(255),
    deleted                 boolean      not null,
    updated_at              timestamp,
    updated_by              varchar(255),
    uuid_str                varchar(255) not null,
    account_non_expired     boolean,
    account_non_locked      boolean,
    credentials_non_expired boolean,
    email                   varchar(255),
    enabled                 boolean      not null,
    gender                  varchar(255) not null,
    name                    varchar(255) not null,
    password                varchar(512) not null,
    phone                   varchar(255),
    username                varchar(255) not null,
    primary key (id)
);
create table auth.m_users_roles
(
    user_id  int8 not null,
    roles_id int8 not null
);
create table auth.privileges
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    description varchar(255),
    label       varchar(255) not null,
    name        varchar(255) not null,
    primary key (id)
);
create table auth.privileges_access_urls
(
    privilege_id int8 not null,
    access_urls  varchar(255)
);
create table auth.roles
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    description varchar(255),
    name        varchar(255) not null,
    restricted  boolean      not null,
    primary key (id)
);
create table auth.roles_privileges
(
    role_id      int8 not null,
    privilege_id int8 not null
);
alter table if exists auth.m_users
    add constraint UK_a2ao1y942v9whup5j7dhw4qve unique (uuid_str);
alter table if exists auth.m_users
    add constraint UK_5tyf96frxy09iqb90fag74jl5 unique (email);
alter table if exists auth.m_users
    add constraint UK_7aoads8ubmh10m9uo1kxwpvud unique (phone);
alter table if exists auth.m_users
    add constraint UK_lxevwjnma30s6actvjsblbp6a unique (username);
alter table if exists auth.privileges
    add constraint UK_ivxrkr76qqn0f7agxlv341nmr unique (uuid_str);
alter table if exists auth.privileges
    add constraint UK_duexhdry3ikhubr339uo893c0 unique (label);
alter table if exists auth.privileges
    add constraint UK_m2tnonbcaquofx1ccy060ejyc unique (name);
alter table if exists auth.roles
    add constraint UK_k1ercudabcvs864c1vpq5k973 unique (uuid_str);
alter table if exists auth.roles
    add constraint UK_ofx66keruapi6vyqpv6f2or37 unique (name);
create table core_web.activity_logs
(
    id             bigserial    not null,
    created_at     timestamp    not null,
    created_by     varchar(255),
    deleted        boolean      not null,
    updated_at     timestamp,
    updated_by     varchar(255),
    uuid_str       varchar(255) not null,
    expires        varchar(255),
    ip             varchar(255),
    request_method varchar(255),
    total_visitors int8,
    url            varchar(255),
    user_agent     varchar(255),
    user_id        int8,
    primary key (id)
);
create table core_web.addr_addresses
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    altitude    float8       not null,
    latitude    float8       not null,
    longitude   float8       not null,
    district_id int8,
    division_id int8,
    union_id    int8,
    upazila_id  int8,
    village_id  int8,
    primary key (id)
);
create table core_web.addr_districts
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    name_bn     varchar(255),
    name_en     varchar(255),
    division_id int8,
    primary key (id)
);
create table core_web.addr_divisions
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    name_bn    varchar(255),
    name_en    varchar(255),
    primary key (id)
);
create table core_web.addr_unions
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    name_bn    varchar(255),
    name_en    varchar(255),
    upazila_id int8,
    primary key (id)
);
create table core_web.addr_upazilas
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    name_bn     varchar(255),
    name_en     varchar(255),
    thana       boolean,
    district_id int8,
    primary key (id)
);
create table core_web.addr_villages
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    name_bn    varchar(255),
    name_en    varchar(255),
    union_id   int8,
    primary key (id)
);
create table core_web.email_logs
(
    id                bigserial    not null,
    created_at        timestamp    not null,
    created_by        varchar(255),
    deleted           boolean      not null,
    updated_at        timestamp,
    updated_by        varchar(255),
    uuid_str          varchar(255) not null,
    mail_bcc          VARCHAR(511),
    mail_cc           VARCHAR(511),
    mail_from         varchar(255) not null,
    message           TEXT,
    no_of_attachments int4,
    subject           VARCHAR(511),
    mail_to           varchar(255) not null,
    primary key (id)
);
alter table if exists core_web.activity_logs
    add constraint UK_ifu41tx2iak05imsolm84dk6a unique (uuid_str);
alter table if exists core_web.addr_addresses
    add constraint UK_8o6n939s99o8e0dtg387afmad unique (uuid_str);
alter table if exists core_web.addr_districts
    add constraint UK_lhl330jnomp0rv4qr1nathl5s unique (uuid_str);
alter table if exists core_web.addr_divisions
    add constraint UK_kaxu9ve9o8tvast01vhuncxav unique (uuid_str);
alter table if exists core_web.addr_unions
    add constraint UK_ah86xt5p56sw6837ypv054ahb unique (uuid_str);
alter table if exists core_web.addr_upazilas
    add constraint UK_rql8pc84dnumra9v3y0pj8n26 unique (uuid_str);
alter table if exists core_web.addr_villages
    add constraint UK_eep7t985xda38lylb9d6egy87 unique (uuid_str);
alter table if exists core_web.email_logs
    add constraint UK_su3fqoxs6j6ok28py61o6o97j unique (uuid_str);
create table messaging.chat_chatroom_users
(
    chat_room_id int8 not null,
    users        varchar(255)
);
create table messaging.chat_chatrooms
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    title      varchar(255),
    primary key (id)
);
create table messaging.chat_messages
(
    id            bigserial    not null,
    created_at    timestamp    not null,
    created_by    varchar(255),
    deleted       boolean      not null,
    updated_at    timestamp,
    updated_by    varchar(255),
    uuid_str      varchar(255) not null,
    content       varchar(255),
    from_username varchar(255),
    chat_room_id  int8         not null,
    primary key (id)
);
alter table if exists messaging.chat_chatrooms
    add constraint UK_jk94guy6aw7vp96pnlra2es72 unique (uuid_str);
alter table if exists messaging.chat_messages
    add constraint UK_1t7eq084xgblhaukfr5m5kn6h unique (uuid_str);
create table vfs.vfs_extensions
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    ext        varchar(255),
    name       varchar(255),
    url_prefix varchar(255),
    primary key (id)
);
create table vfs.vfs_folders
(
    id           bigserial    not null,
    created_at   timestamp    not null,
    created_by   varchar(255),
    deleted      boolean      not null,
    updated_at   timestamp,
    updated_by   varchar(255),
    uuid_str     varchar(255) not null,
    accent_color varchar(255),
    description  TEXT,
    name         varchar(255) not null,
    path         varchar(255),
    thumbnail    varchar(255),
    parent_id    int8,
    primary key (id)
);
alter table if exists vfs.vfs_extensions
    add constraint UK_8q75as6hn4fk7lvui78a8uade unique (uuid_str);
alter table if exists vfs.vfs_folders
    add constraint UK_n8cdf21n042tmgy9s149onq7m unique (uuid_str);
create table firebase_user_token
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    user_token varchar(255) not null,
    user_id    int8,
    primary key (id)
);
create table remote_config
(
    id                   bigserial    not null,
    created_at           timestamp    not null,
    created_by           varchar(255),
    deleted              boolean      not null,
    updated_at           timestamp,
    updated_by           varchar(255),
    uuid_str             varchar(255) not null,
    app_name             varchar(255) not null,
    app_package          varchar(255) not null,
    app_url              varchar(255),
    current_app_version  varchar(255) not null,
    force_update         boolean,
    previous_app_version varchar(255) not null,
    turned_off           boolean,
    primary key (id)
);
create table uploaded_files
(
    id              bigserial    not null,
    created_at      timestamp    not null,
    created_by      varchar(255),
    deleted         boolean      not null,
    updated_at      timestamp,
    updated_by      varchar(255),
    uuid_str        varchar(255) not null,
    file_name       varchar(255),
    file_type       varchar(255),
    namespace       varchar(255),
    root_path       varchar(255),
    unique_property varchar(255),
    primary key (id)
);
alter table if exists firebase_user_token
    add constraint UK_i3peei40osalclyscoyka6hbu unique (uuid_str);
alter table if exists remote_config
    add constraint UK_8y9xfk9d08f60lr5ijmordjmi unique (uuid_str);
alter table if exists uploaded_files
    add constraint UK_f63xqbc6m55voreta9tgqwqy unique (uuid_str);
alter table if exists acl.ac_validation_tokens
    add constraint FKi746ajdn1vcbojvapsq6jsc9u foreign key (user_id) references auth.m_users;
alter table if exists app.profiles
    add constraint FKiebuwbkswan5oolakejxgsnvf foreign key (address_id) references core_web.addr_addresses;
alter table if exists app.profiles
    add constraint FKonpp2s5vianwi6kh3800cqriv foreign key (user_id) references auth.m_users;
alter table if exists auth.m_users_roles
    add constraint FK5hwrg9mw7hmdq8cn63mh7sx0j foreign key (roles_id) references auth.roles;
alter table if exists auth.m_users_roles
    add constraint FK143dfv8wd8b2w93gbvd84ps5k foreign key (user_id) references auth.m_users;
alter table if exists auth.privileges_access_urls
    add constraint FKp123f0u3yvp9ygtxbc1kmff5d foreign key (privilege_id) references auth.privileges;
alter table if exists auth.roles_privileges
    add constraint FK5duhoc7rwt8h06avv41o41cfy foreign key (privilege_id) references auth.privileges;
alter table if exists auth.roles_privileges
    add constraint FK629oqwrudgp5u7tewl07ayugj foreign key (role_id) references auth.roles;
alter table if exists core_web.activity_logs
    add constraint FKi1mahmfxp15s84l940o3nxg19 foreign key (user_id) references auth.m_users;
alter table if exists core_web.addr_addresses
    add constraint FKq7jex59jkxy7ajdkyyc9bp494 foreign key (district_id) references core_web.addr_districts;
alter table if exists core_web.addr_addresses
    add constraint FKgi9t0jl90g7yq9o4n2barr9l4 foreign key (division_id) references core_web.addr_divisions;
alter table if exists core_web.addr_addresses
    add constraint FKnv1depj8rsnftij52lxpxbq4w foreign key (union_id) references core_web.addr_unions;
alter table if exists core_web.addr_addresses
    add constraint FKnfahui7uycqc0l2gnm53d0uav foreign key (upazila_id) references core_web.addr_upazilas;
alter table if exists core_web.addr_addresses
    add constraint FKj3sq3fkq0xykyc05dbc0rorva foreign key (village_id) references core_web.addr_villages;
alter table if exists core_web.addr_districts
    add constraint FKghoqovcvly06mikeskpqxn830 foreign key (division_id) references core_web.addr_divisions;
alter table if exists core_web.addr_unions
    add constraint FKg7hdpqsb02w4otfiqs1oagmm3 foreign key (upazila_id) references core_web.addr_upazilas;
alter table if exists core_web.addr_upazilas
    add constraint FK42he4xymxht59qauu021iit9t foreign key (district_id) references core_web.addr_districts;
alter table if exists core_web.addr_villages
    add constraint FKnavqm8idv3axcj04hum8h41kj foreign key (union_id) references core_web.addr_unions;
alter table if exists messaging.chat_chatroom_users
    add constraint FKlrecp4psy3a7xgprj3a7d6wun foreign key (chat_room_id) references messaging.chat_chatrooms;
alter table if exists messaging.chat_messages
    add constraint FKdm2ves715qutd01dp26mvjglm foreign key (chat_room_id) references messaging.chat_chatrooms;
alter table if exists vfs.vfs_folders
    add constraint FK1wulxxd7mghr0vnmxv2cowyii foreign key (parent_id) references vfs.vfs_folders;
alter table if exists firebase_user_token
    add constraint FKijg4ywkf6r83uvyp905o6omwc foreign key (user_id) references auth.m_users;


create table core_web.location_types
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    code        varchar(255) not null,
    description varchar(255) not null,
    label       varchar(255) not null,
    parent_id   bigint       null references core_web.location_types,
    primary key (id)
);
alter table if exists core_web.location_types
    add constraint UK_8uclq1kkf5hotxqdya4kxmrha unique (uuid_str);
alter table if exists core_web.location_types
    add constraint UK_5ncliyij68finh5pk31l18xy7 unique (code);

create table core_web.locations
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    altitude    float8       not null,
    code        varchar(255) not null,
    description varchar(255),
    label       varchar(255) not null,
    latitude    float8       not null,
    longitude   float8       not null,
    parent_id   bigint       null references core_web.locations,
    type_id     bigint       not null references core_web.location_types,
    primary key (id)
);

alter table if exists core_web.locations
    add constraint UK_45h1u604nv1wxu20l36nkkp0w unique (uuid_str);
alter table if exists core_web.locations
    add constraint UK_njcw38t3qcy312pglqpf3pd59 unique (code);

create table core_web.global_addresss
(
    id               bigserial    not null,
    created_at       timestamp    not null,
    created_by       varchar(255),
    deleted          boolean      not null,
    updated_at       timestamp,
    updated_by       varchar(255),
    uuid_str         varchar(255) not null,
    address_line_one varchar(255) not null,
    address_line_two varchar(255),
    zip_code         varchar(255),
    location_id      int8         not null,
    primary key (id)
);
alter table if exists core_web.global_addresss
    add constraint UK_q9oqaf1s9030mc49ld7so4bxt unique (uuid_str);
alter table if exists core_web.global_addresss
    add constraint FKlsldtrg0te48jaychrl46xq96 foreign key (location_id) references core_web.locations;

alter table core_web.location_types add column level int4 not null default 0;

alter table core_web.global_addresss add column latitude double precision not null default 0.0;
alter table core_web.global_addresss add column longitude double precision not null default 0.0;
alter table core_web.global_addresss add column altitude double precision not null default 0.0;


drop table if exists auth.privileges_access_urls;

create table auth.url_accesses
(
    id           bigserial    not null,
    created_at   timestamp    not null,
    created_by   varchar(255),
    deleted      boolean      not null,
    updated_at   timestamp,
    updated_by   varchar(255),
    uuid_str     varchar(255) not null,
    access_level varchar(255) not null,
    url          varchar(255) not null,
    privilege_id int8         not null,
    primary key (id)
);
alter table if exists auth.url_accesses
    add constraint UK_coxmhnwnbom5xdb78ufvm62yk unique (uuid_str);
alter table if exists auth.url_accesses
    add constraint FKpqjwffbupefmw8vo83e22gnaj foreign key (privilege_id) references auth.privileges;

alter table core_web.location_types add path varchar(255) null;
alter table core_web.locations add path varchar(255) null;

create table core_web.contacts
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    email      varchar(255),
    name       varchar(255) not null,
    phone      varchar(255) not null,
    primary key (id)
);
alter table if exists core_web.contacts add constraint UK_ovv7s65bmp5dw3h8f2fxxtqxy unique (uuid_str);

alter table core_web.global_addresss add column title varchar(255) not null default '';

create table core_web.contact_addresses
(
    contact_id int8 not null,
    address_id int8 not null
);

alter table if exists core_web.contact_addresses
    add constraint UK_mxmb2y0iu8624h4rrdamayobp unique (address_id);
alter table if exists core_web.contact_addresses
    add constraint FKprj22aiexaxnslegti8rkvkc8 foreign key (address_id) references core_web.global_addresss;
alter table if exists core_web.contact_addresses
    add constraint FK1by3vge8px26bvlpc6lbv6ocf foreign key (contact_id) references core_web.contacts;

-- New Migration
create table if not exists acl.profiles
(
    id bigserial NOT NULL,
    created_at     timestamp    NOT NULL,
    created_by     varchar(255),
    deleted        boolean      NOT NULL,
    updated_at     timestamp,
    updated_by     varchar(255),
    uuid_str       varchar(255) NOT NULL,

    birthday       timestamp    NOT NULL,
    photo          varchar(255),
    gender         varchar(100) NOT NULL,
    blood_group    varchar(100),
    marital_status varchar(100),
    religion       varchar(100),
    user_id        bigint references auth.m_users,
    contact_id     bigint references core_web.contacts,
    primary key (id)
);


-- New Migration
alter table acl.profiles drop column contact_id;

delete from core_web.contacts where true;
alter table core_web.contacts add column user_id bigint not null default 0 references auth.m_users;
update auth.m_users set gender='NOT_SPECIFIED' where true;
alter table acl.profiles drop gender;

alter table core_web.contacts add column is_self boolean not null default false;
alter table core_web.contact_addresses drop constraint UK_mxmb2y0iu8624h4rrdamayobp;
alter table core_web.locations add column image varchar(511) null;

truncate table core_web.contacts restart identity cascade;
alter table core_web.contacts add column address_id bigint not null default 0 references core_web.global_addresss;
drop table core_web.contact_addresses;

-- New Migration
create schema if not exists cms;
alter schema cms owner to demouser;

alter table uploaded_files set schema cms;

create table cms.content_templates
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    content    TEXT     not null,
    title      varchar(255) not null,
    primary key (id)
);
alter table if exists cms.content_templates
    add constraint UK_inyc6dj2hy6mvobe2vf79jbr7 unique (uuid_str);

create table cms.c_template_placeholders
(
    content_template_id int8 not null,
    placeholders        varchar(255)
);
alter table if exists cms.c_template_placeholders
    add constraint FKbgqpnpuw1s1xfn5kaflmfh4ej foreign key (content_template_id) references cms.content_templates;
create table cms.prepared_contents
(
    id               bigserial    not null,
    created_at       timestamp    not null,
    created_by       varchar(255),
    deleted          boolean      not null,
    updated_at       timestamp,
    updated_by       varchar(255),
    uuid_str         varchar(255) not null,
    resolved_content varchar(255) not null,
    status           varchar(255) not null,
    template_id      int8         not null,
    primary key (id)
);
alter table if exists cms.prepared_contents
    add constraint UK_4msnrbx18cm83j5ij7t3av71t unique (uuid_str);
alter table if exists cms.prepared_contents
    add constraint FKdbl4evstmjtdv99ug2cltwu3k foreign key (template_id) references cms.content_templates;

create table cms.content_ph_values
(
    prepared_content_id int8         not null,
    ph_value            varchar(255) not null,
    placeholder         varchar(255) not null,
    primary key (prepared_content_id, placeholder)
);
alter table if exists cms.content_ph_values
    add constraint FKk9bnfo5u0pf7wd28txmi49ajc foreign key (prepared_content_id) references cms.prepared_contents;

alter table cms.prepared_contents add column title varchar(255) not null default '';

alter table cms.prepared_contents alter resolved_content type text;

-- New Migration
alter table cms.content_templates add column type varchar(12) not null default 'GENERAL';
update cms.content_templates set type = 'GENERAL' WHERE true;

-- New Migration
create table cms.site_pages
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    description varchar(255),
    slug        varchar(255) not null,
    title       varchar(255) not null,
    primary key (id)
);

alter table if exists cms.site_pages
    add constraint UK_7pp4yryhdrai0ve3r4kro1mst unique (uuid_str);

create table cms.sites
(
    id              bigserial    not null,
    created_at      timestamp    not null,
    created_by      varchar(255),
    deleted         boolean      not null,
    updated_at      timestamp,
    updated_by      varchar(255),
    uuid_str        varchar(255) not null,
    description     varchar(255),
    domain          varchar(255) not null,
    tagline         varchar(255) not null,
    title           varchar(255) not null,
    content_page_id int8,
    home_page_id    int8,
    owner_id        int8         not null,
    primary key (id)
);
alter table if exists cms.sites
    add constraint FKo5bopbcoyv017c9pqspi6971i foreign key (content_page_id) references cms.site_pages;
alter table if exists cms.sites
    add constraint FKo6p0ys3919cylg9oqu41r6y8w foreign key (home_page_id) references cms.site_pages;
alter table if exists cms.sites
    add constraint UK_s0ju9x1aae3kxhfln4vxe0emn unique (uuid_str);
alter table if exists cms.sites
    add constraint FKeok06lq731656kw31xgji0m3f foreign key (owner_id) references auth.m_users;
-- New Migration
create table cms.site_contents
(
    id           bigserial    not null,
    created_at   timestamp    not null,
    created_by   varchar(255),
    deleted      boolean      not null,
    updated_at   timestamp,
    updated_by   varchar(255),
    uuid_str     varchar(255) not null,
    content      TEXT         not null,
    published    boolean,
    published_on timestamp,
    slug         varchar(255) not null,
    title        varchar(255) not null,
    site_id      int8         not null,
    primary key (id)
);
alter table if exists cms.site_contents
    add constraint UK_sgqwxldl4myqwdh4qvbgx2r2g unique (uuid_str);
alter table if exists cms.site_contents
    add constraint FK3sa6d587g9kqpjx3dfnw00l7b foreign key (site_id) references cms.sites;

alter table if exists cms.site_pages add column content_id bigint not null default 0 references cms.site_contents;
alter table if exists cms.site_pages add column site_id bigint not null default 0 references cms.sites;
-- New Migration
truncate table cms.sites restart identity cascade;
alter table cms.sites add unique(domain);

truncate table cms.site_pages restart identity cascade;
alter table cms.site_pages add unique(slug);

truncate table cms.site_contents restart identity cascade;
alter table cms.site_contents add unique(slug);
-- New Migration
alter table cms.site_pages drop content_id;
truncate table cms.site_pages restart identity cascade;
alter table cms.site_pages add column content text not null default '';

-- New Migration
alter table core_web.locations add column zip_code varchar(100);

alter table auth.m_users add column photo varchar(512) null;
alter table auth.m_users rename column photo to avatar;

-- New Migration
alter table acl.profiles
    add is_public boolean null default false;
update acl.profiles set is_public=true where true;
alter table acl.profiles alter column is_public set not null;

-- Mar 29, 2022
CREATE SCHEMA files;
ALTER SCHEMA files OWNER TO demouser;

ALTER TABLE cms.uploaded_files SET SCHEMA files;

-- Nov 5, 2023
create table core_web.labels
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    version     bigint       not null default 1,
    path        varchar(255),
    color       int4         not null,
    description varchar(500) not null,
    image       varchar(255),
    name        varchar(255) not null,
    parent_id   int8,
    primary key (id)
);
alter table if exists core_web.labels
    add constraint UK_3a6fqxscl3xyb6g98vgs4af30 unique (uuid_str);
alter table if exists core_web.labels
    add constraint FKn4bx30fm5qlwx5c61p66sgq0k foreign key (parent_id) references core_web.labels;
-- New Migration
alter table core_web.labels alter column color type varchar(255);


-- Nov 25, 2023
alter table core_web.labels add column background_color varchar(10) not null default '#FFFFFF';
update core_web.labels set color='#000000' where true;
alter table core_web.labels alter column color type varchar(10);
alter table core_web.labels alter column color set not null;

alter table core_web.labels add column icon varchar(255) null;
alter table core_web.labels add column ui_height int not null default 100;

-- Nov 25, 2023
alter table core_web.labels add code varchar(100) null;
update core_web.labels set code=uuid_str where true;
alter table core_web.labels alter column code set not null;

-- Nov 26, 2023
alter table core_web.labels add serial integer not null default 0;
alter table core_web.labels add flagship boolean not null default false;

-- Jan 1, 2024
-- New Migration
CREATE TABLE auth.request_credentials
(
    id                                      bigserial    not null,
    created_at                              timestamp    not null,
    created_by                              varchar(255),
    deleted                                 boolean      not null,
    updated_at                              timestamp,
    updated_by                              varchar(255),
    uuid_str                                varchar(255) not null,
    version                                 bigint       not null default 1,

    -- Significant Headers
    ip                                      inet,
    body                                    text,
    user_agent_header                       TEXT,
    x_forwarded_for_header                  TEXT,
    authorization_header                    TEXT,
    cookie_header                           TEXT,
    referer_header                          TEXT,
    x_frame_options_header                  VARCHAR(256),
    content_type_header                     VARCHAR(256),
    origin_header                           VARCHAR(256),
    x_http_method_override_header           VARCHAR(256),
    content_security_policy_header          TEXT,

    -- Non-Significant Headers
    accept_header                           TEXT,
    accept_language_header                  VARCHAR(256),
    host_header                             VARCHAR(256),
    cache_control_header                    VARCHAR(256),
    connection_header                       VARCHAR(256),
    content_length_header                   VARCHAR(256),
    if_modified_since_header                VARCHAR(256),
    if_none_match_header                    VARCHAR(256),
    accept_encoding_header                  TEXT,
    range_header                            VARCHAR(256),
    x_requested_with_header                 VARCHAR(256),
    x_forwarded_host_header                 VARCHAR(256),
    x_forwarded_proto_header                VARCHAR(256),
    dnt_header                              VARCHAR(256),
    accept_charset_header                   VARCHAR(256),
    accept_datetime_header                  VARCHAR(256),
    access_control_request_method_header    VARCHAR(256),
    access_control_request_headers_header   VARCHAR(256),
    forward_header                          VARCHAR(256),
    max_forwards_header                     VARCHAR(256),
    pragma_header                           VARCHAR(256),
    proxy_authorization_header              VARCHAR(256),
    te_header                               VARCHAR(256),
    upgrade_header                          VARCHAR(256),
    via_header                              VARCHAR(256),
    warning_header                          VARCHAR(256),
    access_control_allow_origin_header      VARCHAR(256),
    access_control_expose_headers_header    VARCHAR(256),
    access_control_allow_credentials_header VARCHAR(256),
    access_control_max_age_header           VARCHAR(256),
    access_control_allow_methods_header     VARCHAR(256),
    access_control_allow_headers_header     VARCHAR(256),
    authorization_info_header               VARCHAR(256),
    content_encoding_header                 VARCHAR(256),
    forwarded_for_header                    VARCHAR(256),
    if_range_header                         VARCHAR(256),
    if_unmodified_since_header              VARCHAR(256),

    primary key (id)
);

alter table if exists auth.request_credentials
    add constraint UK_3a6fqxscl3xyb6hfiduwy74 unique (uuid_str);

-- New Migration
alter table auth.request_credentials add column invalidated boolean not null default false;

-- New Migration
ALTER TABLE auth.request_credentials ALTER COLUMN ip TYPE varchar(20);
-- New Migration
alter table auth.request_credentials add column uri varchar(255);

-- Jan 1, 2024 - 2
-- New Migration
alter table core_web.labels add code varchar(100) null;
update core_web.labels set code=uuid_str where true;
alter table core_web.labels alter column code set not null;

-- New Migration
alter table core_web.labels add serial integer not null default 0;
alter table core_web.labels add flagship boolean not null default false;

alter table acl.ac_validation_tokens add column reg_method varchar(20);

-- New Migration
create table files.uploaded_images
(
    id         bigserial    not null,
    created_at timestamp    not null,
    created_by varchar(255),
    deleted    boolean      not null,
    updated_at timestamp,
    updated_by varchar(255),
    uuid_str   varchar(255) not null,
    image_id   int8,
    thumb_id   int8,
    primary key (id)
);
alter table if exists files.uploaded_images
    add constraint UK_ropusxgnb7mh5jv9da0qbg5pn unique (uuid_str);
alter table if exists files.uploaded_images
    add constraint FKf8lmu7jemk18n84tidvlcukwx foreign key (image_id) references files.uploaded_files;
alter table if exists files.uploaded_images
    add constraint FKlvffcd01tmly246p94xt9do7t foreign key (thumb_id) references files.uploaded_files;

-- New Migration
alter table files.uploaded_images add column version bigint not null default 1;

-- Jan 9, 2024
alter table cms.prepared_contents add column css_classes varchar(255) not null default '';

-- Jan 24, 2024
-- New Migration
alter table cms.content_templates add column code varchar(255);
update cms.content_templates set code = uuid_str where true;
alter table cms.content_templates alter column code set not null;
alter table cms.content_templates add constraint content_templates_code_unique unique (code);

alter table cms.content_templates add column version bigint not null default 1;

-- New Migration
alter table cms.content_templates add column css_classes varchar(255) not null default '';
alter table cms.prepared_contents drop column css_classes;

-- Feb 17, 2024
create table core_web.qrtz_job_details
(
    sched_name        varchar(120) not null,
    job_name          varchar(200) not null,
    job_group         varchar(200) not null,
    description       varchar(250),
    job_class_name    varchar(250) not null,
    is_durable        boolean      not null,
    is_nonconcurrent  boolean      not null,
    is_update_data    boolean      not null,
    requests_recovery boolean      not null,
    job_data          bytea,
    primary key (sched_name, job_name, job_group)
);

alter table core_web.qrtz_job_details
    owner to demouser;

create index idx_qrtz_j_req_recovery
    on core_web.qrtz_job_details (sched_name, requests_recovery);

create index idx_qrtz_j_grp
    on core_web.qrtz_job_details (sched_name, job_group);

create table core_web.qrtz_triggers
(
    sched_name     varchar(120) not null,
    trigger_name   varchar(200) not null,
    trigger_group  varchar(200) not null,
    job_name       varchar(200) not null,
    job_group      varchar(200) not null,
    description    varchar(250),
    next_fire_time bigint,
    prev_fire_time bigint,
    priority       integer,
    trigger_state  varchar(16)  not null,
    trigger_type   varchar(8)   not null,
    start_time     bigint       not null,
    end_time       bigint,
    calendar_name  varchar(200),
    misfire_instr  smallint,
    job_data       bytea,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, job_name, job_group) references core_web.qrtz_job_details
);

alter table core_web.qrtz_triggers
    owner to demouser;

create index idx_qrtz_t_j
    on core_web.qrtz_triggers (sched_name, job_name, job_group);

create index idx_qrtz_t_jg
    on core_web.qrtz_triggers (sched_name, job_group);

create index idx_qrtz_t_c
    on core_web.qrtz_triggers (sched_name, calendar_name);

create index idx_qrtz_t_g
    on core_web.qrtz_triggers (sched_name, trigger_group);

create index idx_qrtz_t_state
    on core_web.qrtz_triggers (sched_name, trigger_state);

create index idx_qrtz_t_n_state
    on core_web.qrtz_triggers (sched_name, trigger_name, trigger_group, trigger_state);

create index idx_qrtz_t_n_g_state
    on core_web.qrtz_triggers (sched_name, trigger_group, trigger_state);

create index idx_qrtz_t_next_fire_time
    on core_web.qrtz_triggers (sched_name, next_fire_time);

create index idx_qrtz_t_nft_st
    on core_web.qrtz_triggers (sched_name, trigger_state, next_fire_time);

create index idx_qrtz_t_nft_misfire
    on core_web.qrtz_triggers (sched_name, misfire_instr, next_fire_time);

create index idx_qrtz_t_nft_st_misfire
    on core_web.qrtz_triggers (sched_name, misfire_instr, next_fire_time, trigger_state);

create index idx_qrtz_t_nft_st_misfire_grp
    on core_web.qrtz_triggers (sched_name, misfire_instr, next_fire_time, trigger_group, trigger_state);

create table core_web.qrtz_simple_triggers
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    repeat_count    bigint       not null,
    repeat_interval bigint       not null,
    times_triggered bigint       not null,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group) references core_web.qrtz_triggers
);

alter table core_web.qrtz_simple_triggers
    owner to demouser;

create table core_web.qrtz_cron_triggers
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    cron_expression varchar(120) not null,
    time_zone_id    varchar(80),
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group) references core_web.qrtz_triggers
);

alter table core_web.qrtz_cron_triggers
    owner to demouser;

create table core_web.qrtz_simprop_triggers
(
    sched_name    varchar(120) not null,
    trigger_name  varchar(200) not null,
    trigger_group varchar(200) not null,
    str_prop_1    varchar(512),
    str_prop_2    varchar(512),
    str_prop_3    varchar(512),
    int_prop_1    integer,
    int_prop_2    integer,
    long_prop_1   bigint,
    long_prop_2   bigint,
    dec_prop_1    numeric(13, 4),
    dec_prop_2    numeric(13, 4),
    bool_prop_1   boolean,
    bool_prop_2   boolean,
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey
        foreign key (sched_name, trigger_name, trigger_group) references core_web.qrtz_triggers
);

alter table core_web.qrtz_simprop_triggers
    owner to demouser;

create table core_web.qrtz_blob_triggers
(
    sched_name    varchar(120) not null,
    trigger_name  varchar(200) not null,
    trigger_group varchar(200) not null,
    blob_data     bytea,
    primary key (sched_name, trigger_name, trigger_group),
    foreign key (sched_name, trigger_name, trigger_group) references core_web.qrtz_triggers
);

alter table core_web.qrtz_blob_triggers
    owner to demouser;

create table core_web.qrtz_calendars
(
    sched_name    varchar(120) not null,
    calendar_name varchar(200) not null,
    calendar      bytea        not null,
    primary key (sched_name, calendar_name)
);

alter table core_web.qrtz_calendars
    owner to demouser;

create table core_web.qrtz_paused_trigger_grps
(
    sched_name    varchar(120) not null,
    trigger_group varchar(200) not null,
    primary key (sched_name, trigger_group)
);

alter table core_web.qrtz_paused_trigger_grps
    owner to demouser;

create table core_web.qrtz_fired_triggers
(
    sched_name        varchar(120) not null,
    entry_id          varchar(95)  not null,
    trigger_name      varchar(200) not null,
    trigger_group     varchar(200) not null,
    instance_name     varchar(200) not null,
    fired_time        bigint       not null,
    sched_time        bigint       not null,
    priority          integer      not null,
    state             varchar(16)  not null,
    job_name          varchar(200),
    job_group         varchar(200),
    is_nonconcurrent  boolean,
    requests_recovery boolean,
    primary key (sched_name, entry_id)
);

alter table core_web.qrtz_fired_triggers
    owner to demouser;

create index idx_qrtz_ft_trig_inst_name
    on core_web.qrtz_fired_triggers (sched_name, instance_name);

create index idx_qrtz_ft_inst_job_req_rcvry
    on core_web.qrtz_fired_triggers (sched_name, instance_name, requests_recovery);

create index idx_qrtz_ft_j_g
    on core_web.qrtz_fired_triggers (sched_name, job_name, job_group);

create index idx_qrtz_ft_jg
    on core_web.qrtz_fired_triggers (sched_name, job_group);

create index idx_qrtz_ft_t_g
    on core_web.qrtz_fired_triggers (sched_name, trigger_name, trigger_group);

create index idx_qrtz_ft_tg
    on core_web.qrtz_fired_triggers (sched_name, trigger_group);

create table core_web.qrtz_scheduler_state
(
    sched_name        varchar(120) not null,
    instance_name     varchar(200) not null,
    last_checkin_time bigint       not null,
    checkin_interval  bigint       not null,
    primary key (sched_name, instance_name)
);

alter table core_web.qrtz_scheduler_state
    owner to demouser;

create table core_web.qrtz_locks
(
    sched_name varchar(120) not null,
    lock_name  varchar(40)  not null,
    primary key (sched_name, lock_name)
);

alter table core_web.qrtz_locks
    owner to demouser;

-- New Migration
create table core_web.configurations
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    version     bigint       not null default 1,
    namespace   varchar(20)  not null,
    config_type varchar(20)  not null,
    value_type  varchar(20)  not null,
    key         varchar(50)  not null,
    value       varchar(255) not null,
    description varchar(255),
    primary key (id)
);
alter table if exists core_web.configurations
    add constraint UK_eix34l3hjc91pr6apn8254c3s unique (uuid_str);
alter table if exists core_web.configurations
    add constraint UK_2q3v3v3hjc91764hdg763gh67 unique (namespace, config_type, key);

-- Mar 24, 2024
alter table auth.m_users add column time_zone varchar(127) not null default 'UTC';
update auth.m_users set time_zone = 'Asia/Dhaka' where time_zone='UTC';

create table core_web.allowed_domains
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    version     bigint       not null default 1,
    active      boolean      not null,
    description varchar(255) not null,
    domain       varchar(255) not null,
    primary key (id)
);
alter table if exists core_web.allowed_domains
    add constraint UK_fv3cfk9hb2g4bev7r6mcgxl32 unique (uuid_str);
alter table if exists core_web.allowed_domains
    add constraint UK_rpw992ceh6gyn3t75yg52kwha unique (domain);

-- Mar 24, 2024
INSERT INTO core_web.allowed_domains
(id, created_at, created_by, deleted, updated_at, updated_by, uuid_str, version, active, description, domain)
VALUES (1, '2024-03-24 17:30:17.000000', null, false, null, null, '3c38a6d2-ee40-43ee-a2a8-7c1616ce9279', 1, true, 'Domain for localhost', 'localhost');


-- Apr 18, 2024
create table core_web.events
(
    id              bigserial    not null,
    created_at      timestamp    not null,
    created_by      varchar(255),
    deleted         boolean      not null,
    updated_at      timestamp,
    updated_by      varchar(255),
    uuid_str        varchar(255) not null,
    version         bigint       not null default 1,
    description     text         not null,
    end_at          timestamp,
    image           varchar(255),
    active          boolean      not null default true,
    repeat_count    int4         not null,
    repeat_interval int8         not null,
    repetitive      boolean      not null,
    scheduler_group varchar(255) not null,
    scheduler_uid   varchar(255) not null,
    start_at        timestamp    not null,
    title           varchar(255) not null,
    type            varchar(255) not null,
    ref_id          int8,
    user_id         int8         not null,
    primary key (id)
);
alter table if exists core_web.events
    add constraint UK_auxgro4sai6dyk65nqqijgbrb unique (uuid_str);
alter table if exists core_web.events
    add constraint FKic61sj91uk83mlan2asw2u8g4 foreign key (user_id) references auth.m_users;

-- May 08, 2024
alter table core_web.events add column by_email boolean not null default false;
alter table core_web.events add column by_phone boolean not null default false;
alter table core_web.events add column by_push_notification boolean not null default false;

-- Sep 02, 2024
create table core_web.menus
(
    id          bigserial    not null,
    created_at  timestamp    not null,
    created_by  varchar(255),
    deleted     boolean      not null,
    updated_at  timestamp,
    updated_by  varchar(255),
    uuid_str    varchar(255) not null,
    version     bigint       not null default 1,
    path        varchar(255),
    description varchar(255) not null,
    image       varchar(255),
    link        varchar(255),
    title       varchar(255) not null,
    type        int4,
    parent_id   int8,
    primary key (id)
);
alter table if exists core_web.menus
    add constraint UK_i19uiprtmd1o9cga6dbq0hjw2 unique (uuid_str);
alter table if exists core_web.menus
    add constraint FKcctt24h6nix02cxipt9rbqtnc foreign key (parent_id) references core_web.menus;

