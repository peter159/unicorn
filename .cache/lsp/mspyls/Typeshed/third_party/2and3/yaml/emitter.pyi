from typing import Any
from yaml.error import YAMLError

class EmitterError(YAMLError): ...

class ScalarAnalysis:
    scalar = ...  # type: Any
    empty = ...  # type: Any
    multiline = ...  # type: Any
    allow_flow_plain = ...  # type: Any
    allow_block_plain = ...  # type: Any
    allow_single_quoted = ...  # type: Any
    allow_double_quoted = ...  # type: Any
    allow_block = ...  # type: Any
    def __init__(self, scalar, empty, multiline, allow_flow_plain, allow_block_plain, allow_single_quoted, allow_double_quoted, allow_block) -> None: ...

class Emitter:
    DEFAULT_TAG_PREFIXES = ...  # type: Any
    stream = ...  # type: Any
    encoding = ...  # type: Any
    states = ...  # type: Any
    state = ...  # type: Any
    events = ...  # type: Any
    event = ...  # type: Any
    indents = ...  # type: Any
    indent = ...  # type: Any
    flow_level = ...  # type: Any
    root_context = ...  # type: Any
    sequence_context = ...  # type: Any
    mapping_context = ...  # type: Any
    simple_key_context = ...  # type: Any
    line = ...  # type: Any
    column = ...  # type: Any
    whitespace = ...  # type: Any
    indention = ...  # type: Any
    open_ended = ...  # type: Any
    canonical = ...  # type: Any
    allow_unicode = ...  # type: Any
    best_indent = ...  # type: Any
    best_width = ...  # type: Any
    best_line_break = ...  # type: Any
    tag_prefixes = ...  # type: Any
    prepared_anchor = ...  # type: Any
    prepared_tag = ...  # type: Any
    analysis = ...  # type: Any
    style = ...  # type: Any
    def __init__(self, stream, canonical=..., indent=..., width=..., allow_unicode=..., line_break=...) -> None: ...
    def dispose(self): ...
    def emit(self, event): ...
    def need_more_events(self): ...
    def need_events(self, count): ...
    def increase_indent(self, flow=..., indentless=...): ...
    def expect_stream_start(self): ...
    def expect_nothing(self): ...
    def expect_first_document_start(self): ...
    def expect_document_start(self, first=...): ...
    def expect_document_end(self): ...
    def expect_document_root(self): ...
    def expect_node(self, root=..., sequence=..., mapping=..., simple_key=...): ...
    def expect_alias(self): ...
    def expect_scalar(self): ...
    def expect_flow_sequence(self): ...
    def expect_first_flow_sequence_item(self): ...
    def expect_flow_sequence_item(self): ...
    def expect_flow_mapping(self): ...
    def expect_first_flow_mapping_key(self): ...
    def expect_flow_mapping_key(self): ...
    def expect_flow_mapping_simple_value(self): ...
    def expect_flow_mapping_value(self): ...
    def expect_block_sequence(self): ...
    def expect_first_block_sequence_item(self): ...
    def expect_block_sequence_item(self, first=...): ...
    def expect_block_mapping(self): ...
    def expect_first_block_mapping_key(self): ...
    def expect_block_mapping_key(self, first=...): ...
    def expect_block_mapping_simple_value(self): ...
    def expect_block_mapping_value(self): ...
    def check_empty_sequence(self): ...
    def check_empty_mapping(self): ...
    def check_empty_document(self): ...
    def check_simple_key(self): ...
    def process_anchor(self, indicator): ...
    def process_tag(self): ...
    def choose_scalar_style(self): ...
    def process_scalar(self): ...
    def prepare_version(self, version): ...
    def prepare_tag_handle(self, handle): ...
    def prepare_tag_prefix(self, prefix): ...
    def prepare_tag(self, tag): ...
    def prepare_anchor(self, anchor): ...
    def analyze_scalar(self, scalar): ...
    def flush_stream(self): ...
    def write_stream_start(self): ...
    def write_stream_end(self): ...
    def write_indicator(self, indicator, need_whitespace, whitespace=..., indention=...): ...
    def write_indent(self): ...
    def write_line_break(self, data=...): ...
    def write_version_directive(self, version_text): ...
    def write_tag_directive(self, handle_text, prefix_text): ...
    def write_single_quoted(self, text, split=...): ...
    ESCAPE_REPLACEMENTS = ...  # type: Any
    def write_double_quoted(self, text, split=...): ...
    def determine_block_hints(self, text): ...
    def write_folded(self, text): ...
    def write_literal(self, text): ...
    def write_plain(self, text, split=...): ...
