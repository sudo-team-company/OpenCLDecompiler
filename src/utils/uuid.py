import uuid
from typing import Optional


def generate_uuid(
        prefix: Optional[str] = None,
        suffix: Optional[str] = None,
) -> str:
    return (
        f"{'' if not prefix else prefix}"
        f"{str(uuid.uuid4())}"
        f"{'' if not suffix else suffix}"
    )
