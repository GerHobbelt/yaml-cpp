#include "yaml-cpp/exceptions.h"

namespace YAML {

// These destructors are defined out-of-line so the vtable is only emitted once.
Exception::~Exception() BOOST_NOEXCEPT {}
ParserException::~ParserException() BOOST_NOEXCEPT {}
RepresentationException::~RepresentationException() BOOST_NOEXCEPT {}
InvalidScalar::~InvalidScalar() BOOST_NOEXCEPT {}
KeyNotFound::~KeyNotFound() BOOST_NOEXCEPT {}
InvalidNode::~InvalidNode() BOOST_NOEXCEPT {}
BadConversion::~BadConversion() BOOST_NOEXCEPT {}
BadDereference::~BadDereference() BOOST_NOEXCEPT {}
BadSubscript::~BadSubscript() BOOST_NOEXCEPT {}
BadPushback::~BadPushback() BOOST_NOEXCEPT {}
BadInsert::~BadInsert() BOOST_NOEXCEPT {}
EmitterException::~EmitterException() BOOST_NOEXCEPT {}
BadFile::~BadFile() BOOST_NOEXCEPT {}
}
