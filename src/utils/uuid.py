import uuid


def generate_uuid(
    prefix: str | None = None,
    suffix: str | None = None,
) -> str:
    return f"{'' if not prefix else prefix}" f"{str(uuid.uuid4())}" f"{'' if not suffix else suffix}"
