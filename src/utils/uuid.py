import uuid


def generate_uuid(
    prefix: str | None = None,
    suffix: str | None = None,
) -> str:
    return f"{'' if not prefix else prefix}{uuid.uuid4()!s}{'' if not suffix else suffix}"
