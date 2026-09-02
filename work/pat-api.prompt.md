You are a senior Java backend engineer. Build a production-grade REST API for an existing MySQL database using Java, Spring Boot, Spring Data JPA, and Swagger/OpenAPI.

## Context
- Database schema file: `./dlr-pat-latest-schema_20260424.sql`
- This schema is the source of truth. Do not modify the database schema.
- Generate API and JPA mappings from existing tables and foreign key constraints.
- MySQL version is 8.x.

## Tech Requirements
- Java 21
- Spring Boot 3.x
- Spring Data JPA (Hibernate)
- Validation: Jakarta Validation
- API docs: `springdoc-openapi-starter-webmvc-ui`
- Build tool: detect existing project tool (Maven or Gradle) and follow it

## Primary Goal
Create a maintainable REST API layer over this schema with correct JPA relationships inferred from foreign keys, including composite keys where needed.

## Implementation Tasks
1. Parse and analyze `./dlr-pat-latest-schema_20260424.sql`.
2. Produce a **relationship matrix** before coding with columns:
   - child_table
   - child_fk_column(s)
   - parent_table
   - parent_pk_column(s)
   - inferred_cardinality (ManyToOne / OneToOne / ManyToMany-via-join-table / self-reference)
   - nullable (true/false)
   - unique_fk (true/false)
   - JPA owning side
3. Build entities for the core non-backup tables first (exclude obvious backup/archive tables like `*_bkp`, `*_saved` unless asked).
4. Correctly map relationships:
   - `@ManyToOne` for non-unique FK references
   - `@OneToOne` when FK is unique and references one parent row
   - `@OneToMany(mappedBy=...)` inverse side where appropriate
   - `@ManyToMany` only when there is a pure join table; if join table has attributes, model it as an entity
   - Handle self-referencing FKs (example pattern: parent code in same table)
5. Handle composite primary keys using `@Embeddable` + `@EmbeddedId` (preferred) and `@MapsId` for FK associations in junction tables.
6. Use DTOs for API input/output; do not expose entities directly.
7. Implement CRUD endpoints for selected aggregate roots and nested retrieval endpoints where relationships are important.
8. Add pagination and sorting to list endpoints.
9. Add request validation and global exception handling with consistent error payload.
10. Add Swagger/OpenAPI configuration and annotations so endpoints and schemas are visible in Swagger UI.
11. Configure application for MySQL connection via properties/yaml and environment variables.
12. Add tests:
    - JPA mapping tests for key relationships (including composite key entities)
    - Controller integration tests for representative CRUD flows

## Relationship & Mapping Rules
- Infer cardinality from FK + uniqueness constraints.
- `NOT NULL` FK => `optional = false`.
- Default collection relationships to LAZY.
- Avoid recursive JSON serialization issues by using DTO mapping.
- Keep transactions at service layer.
- Avoid Open Session in View anti-pattern.

## API & Code Quality Rules
- Package structure:
  - `config`, `entity`, `repository`, `service`, `controller`, `dto`, `mapper`, `exception`
- Keep naming aligned with table semantics.
- Use clear separation between persistence model and API contracts.
- Prefer minimal, explicit cascade settings (do not overuse `CascadeType.ALL`).

## Deliverables (in order)
1. Relationship matrix inferred from the SQL file.
2. List of included tables and excluded tables (`*_bkp`, `*_saved`, etc.).
3. File-by-file code changes.
4. Run/test commands.
5. Swagger URL (e.g., `/swagger-ui/index.html`) and sample curl commands.
6. Notes on any ambiguous schema areas needing confirmation.

## Execution Notes
- Start by reading and parsing `./dlr-pat-latest-schema_20260424.sql`.
- If an FK relation appears incomplete or missing in DDL, document assumption explicitly.
- Do not silently invent constraints not present in schema.
