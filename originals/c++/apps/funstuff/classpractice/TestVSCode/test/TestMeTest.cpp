#define BOOST_TEST_MODULE TestMeTest
#include "TestMe.hpp"
#define BOOST_TEST_DYN_LINK
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_SUITE(TestMeSuite)
BOOST_AUTO_TEST_CASE(AdditionTest){
    TestMe testStart;
    BOOST_CHECK_EQUAL(testStart.add(1,1), 2);
}
BOOST_AUTO_TEST_SUITE_END():