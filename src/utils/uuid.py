import uuid


def generate_uuid(
    prefix: str | None = None,
    suffix: str | None = None,
) -> str:
    return f"{prefix or ''}{uuid.uuid4()!s}{suffix or ''}"
