#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name constsTest
extends GdUnitTestSuite

const __source = 'res://src/consts.gd'


func test_check_const_season_is_not_modified_the_order___order_of_season_name_matter_in_time_system():
	assert_int(Consts.SEASON.SUMMER).is_equal(0)
	assert_int(Consts.SEASON.AUTUMN).is_equal(1)
	assert_int(Consts.SEASON.WINTER).is_equal(2)
	assert_int(Consts.SEASON.SPRING).is_equal(3)


func test_check_const_weather_is_not_modified_the_order___order_of_weather_name_matter():
	assert_int(Consts.WEEKDAY.MONDAY).is_equal(0)
	assert_int(Consts.WEEKDAY.TUESDAY).is_equal(1)
	assert_int(Consts.WEEKDAY.WEDNESDAY).is_equal(2)
	assert_int(Consts.WEEKDAY.THURSDAY).is_equal(3)
	assert_int(Consts.WEEKDAY.FRIDAY).is_equal(4)
	assert_int(Consts.WEEKDAY.SATURDAY).is_equal(5)
	assert_int(Consts.WEEKDAY.SUNDAY).is_equal(6)
