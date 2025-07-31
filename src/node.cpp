#include "yaml-cpp/node/node.h"
#include "nodebuilder.h"
#include "nodeevents.h"

namespace YAML {
Node Clone(const Node& node, bool preserve_aliases) {
  NodeEvents events(node);
  NodeBuilder builder;
  events.Emit(builder, preserve_aliases);
  return builder.Root();
}
}  // namespace YAML
