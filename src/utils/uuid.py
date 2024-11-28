import uuid


def generate_uuid(
    prefix: str | None = None,
    suffix: str | None = None,
) -> str:
    return f"{prefix if prefix else ''}{uuid.uuid4()!s}{suffix if suffix else ''}"
