import uuid


def generate_uuid(
    prefix: str | None = None,
    suffix: str | None = None,
) -> str:
    return f"{'' if not prefix else prefix}" f"{uuid.uuid4()!s}" f"{'' if not suffix else suffix}"
