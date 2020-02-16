from typing import Any

log = ...  # type: Any

class DataWatch:
    def __init__(self, client, path, func=..., *args, **kwargs) -> None: ...
    def __call__(self, func): ...

class ChildrenWatch:
    def __init__(self, client, path, func=..., allow_session_lost=..., send_event=...) -> None: ...
    def __call__(self, func): ...

class PatientChildrenWatch:
    client = ...  # type: Any
    path = ...  # type: Any
    children = ...  # type: Any
    time_boundary = ...  # type: Any
    children_changed = ...  # type: Any
    def __init__(self, client, path, time_boundary=...) -> None: ...
    asy = ...  # type: Any
    def start(self): ...
