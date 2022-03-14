#include "gtest/gtest.h"



#if defined(BUILD_MONOLITHIC)
#define main(cnt, arr)      yamlcpp_test_main(cnt, arr)
#endif

int main(int argc, const char** argv)
{
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
