#include <fstream>
#include <iostream>
#include <vector>

#include "yaml-cpp/eventhandler.h"
#include "yaml-cpp/yaml.h"  // IWYU pragma: keep

class NullEventHandler : public YAML::EventHandler {
 public:
  void OnDocumentStart(const YAML::Mark&) override {}
  void OnDocumentEnd() override {}

  void OnNull(const YAML::Mark&, YAML::anchor_t) override {}
  void OnAlias(const YAML::Mark&, YAML::anchor_t) override {}
  void OnScalar(const YAML::Mark&, const std::string&, YAML::anchor_t,
                const std::string&) override {}

  void OnSequenceStart(const YAML::Mark&, const std::string&, YAML::anchor_t,
                       YAML::EmitterStyle::value) override {}
  void OnSequenceEnd() override {}

  void OnMapStart(const YAML::Mark&, const std::string&, YAML::anchor_t,
                  YAML::EmitterStyle::value) override {}
  void OnMapEnd() override {}
};

void parse(std::istream& input) {
  try {
    YAML::Node doc = YAML::Load(input);
    std::cout << doc << "\n";
  } catch (const YAML::Exception& e) {
    std::cerr << e.what() << "\n";
  }
}



#if defined(BUILD_MONOLITHIC)
#define main(cnt, arr)      yamlcpp_parse_util_main(cnt, arr)
#endif

int main(int argc, const char** argv)
{
  if (argc > 1) {
    std::ifstream fin;
    fin.open(argv[1]);
    parse(fin);
  } else {
    parse(std::cin);
  }

  return 0;
}
