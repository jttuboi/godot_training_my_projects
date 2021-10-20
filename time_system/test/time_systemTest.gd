#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name time_systemTest
extends GdUnitTestSuite

const __source = 'res://src/time_system.gd'

var time_system


func before():
	time_system = load(__source).new()


func after():
	time_system.free()


func test_get_minute():
	when_minute_is_0m()
	when_minute_is_59m()
	when_minute_is_1h1m()
	when_minute_is_2h3m()
	when_minute_is_6h()

func when_minute_is_0m():
	time_system.time = 0
	assert_int(time_system.get_minute()).is_equal(0)
	
func when_minute_is_59m():
	time_system.time = 59
	assert_int(time_system.get_minute()).is_equal(59)
	
func when_minute_is_1h1m():
	time_system.time = 1*60 + 1
	assert_int(time_system.get_minute()).is_equal(1)
	
func when_minute_is_2h3m():
	time_system.time = 2*60 + 3
	assert_int(time_system.get_minute()).is_equal(3)
	
func when_minute_is_6h():
	time_system.time = 6*60
	assert_int(time_system.get_minute()).is_equal(0)


func test_get_hour():
	when_hour_is_0h()
	when_hour_is_6h()
	when_hour_is_23h59m()
	when_hour_is_1d21h14m()

func when_hour_is_0h():
	time_system.time = 0*Times.TIME_HOUR
	assert_int(time_system.get_hour()).is_equal(0)

func when_hour_is_6h():
	time_system.time = 6*Times.TIME_HOUR
	assert_int(time_system.get_hour()).is_equal(6)

func when_hour_is_23h59m():
	time_system.time = 23*Times.TIME_HOUR + 59
	assert_int(time_system.get_hour()).is_equal(23)

func when_hour_is_1d21h14m():
	time_system.time = 0*Times.TIME_DAY + 21*Times.TIME_HOUR + 14
	assert_int(time_system.get_hour()).is_equal(21)


func test_get_day():
	when_day_is_1d()
	when_day_is_28d13h54m()
	when_day_is_SPRs12d()
	when_day_is_AUTs24d12h()

func when_day_is_1d():
	time_system.time = 0*Times.TIME_DAY
	assert_int(time_system.get_day()).is_equal(1)

func when_day_is_28d13h54m():
	time_system.time = 27*Times.TIME_DAY + 13*Times.TIME_HOUR + 54
	assert_int(time_system.get_day()).is_equal(28)

func when_day_is_SPRs12d():
	time_system.time = Consts.SEASON.SPRING*Times.TIME_SEASON + 11*Times.TIME_DAY
	assert_int(time_system.get_day()).is_equal(12)

func when_day_is_AUTs24d12h():
	time_system.time = Consts.SEASON.AUTUMN*Times.TIME_SEASON + 23*Times.TIME_DAY + 12*Times.TIME_HOUR
	assert_int(time_system.get_day()).is_equal(24)


func test_get_weekday():
	when_day_is_MON_1d()
	when_day_is_SUN_28d13h54m()
	when_day_is_FRI_SPRs12d()
	when_day_is_WED_AUTs24d12h()

func when_day_is_MON_1d():
	time_system.time = 0*Times.TIME_DAY
	assert_int(time_system.get_weekday()).is_equal(Consts.WEEKDAY.MONDAY)

func when_day_is_SUN_28d13h54m():
	time_system.time =27*Times.TIME_DAY + 13*Times.TIME_HOUR + 54
	assert_int(time_system.get_weekday()).is_equal(Consts.WEEKDAY.SUNDAY)

func when_day_is_FRI_SPRs12d():
	time_system.time = Consts.SEASON.SPRING*Times.TIME_SEASON + 11*Times.TIME_DAY
	assert_int(time_system.get_weekday()).is_equal(Consts.WEEKDAY.FRIDAY)

func when_day_is_WED_AUTs24d12h():
	time_system.time = Consts.SEASON.AUTUMN*Times.TIME_SEASON + 23*Times.TIME_DAY + 12*Times.TIME_HOUR
	assert_int(time_system.get_weekday()).is_equal(Consts.WEEKDAY.WEDNESDAY)


func test_get_season():
	when_day_is_SUMs()
	when_day_is_AUTs28d13h54m()
	when_day_is_AUTs12d()
	when_day_is_SPRs24d12h()

func when_day_is_SUMs():
	time_system.time = Consts.SEASON.SUMMER*Times.TIME_SEASON
	assert_int(time_system.get_season()).is_equal(Consts.SEASON.SUMMER)

func when_day_is_AUTs28d13h54m():
	time_system.time = Consts.SEASON.AUTUMN*Times.TIME_SEASON + 27*Times.TIME_DAY + 13*Times.TIME_HOUR + 54
	assert_int(time_system.get_season()).is_equal(Consts.SEASON.AUTUMN)

func when_day_is_AUTs12d():
	time_system.time = Consts.SEASON.AUTUMN*Times.TIME_SEASON + 11*Times.TIME_DAY
	assert_int(time_system.get_season()).is_equal(Consts.SEASON.AUTUMN)

func when_day_is_SPRs24d12h():
	time_system.time = Consts.SEASON.SPRING*Times.TIME_SEASON + 23*Times.TIME_DAY + 12*Times.TIME_HOUR
	assert_int(time_system.get_season()).is_equal(Consts.SEASON.SPRING)


func test_get_year():
	when_day_is_1y()
	when_day_is_2yAUTs28d13h54m()

func when_day_is_1y():
	time_system.time = 1*Times.TIME_YEAR
	assert_int(time_system.get_year()).is_equal(1)

func when_day_is_2yAUTs28d13h54m():
	time_system.time = 2*Times.TIME_YEAR + Consts.SEASON.AUTUMN*Times.TIME_SEASON + 27*Times.TIME_DAY + 13*Times.TIME_HOUR + 54
	assert_int(time_system.get_year()).is_equal(2)


func test_convert_to_time():
	when_time_data_is_0y_SUM_1d_0h_0m()
	when_time_data_is_0y_SUM_1d_0h_59m()
	when_time_data_is_0y_SUM_1d_1h_0m()
	when_time_data_is_0y_SUM_1d_23h_59m()
	when_time_data_is_0y_SUM_2d_0h_0m()
	when_time_data_is_0y_SUM_3d_0h_0m()
	when_time_data_is_0y_SUM_28d_23h_59m()
	when_time_data_is_0y_AUT_1d_0h_0m()
	when_time_data_is_0y_SPR_28d_23h_59m()

func when_time_data_is_0y_SUM_1d_0h_0m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 1, 0, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(0)

func when_time_data_is_0y_SUM_1d_0h_59m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 1, 0, 59)
	assert_float(time_system.convert_to_time(time_data)).is_equal(59)

func when_time_data_is_0y_SUM_1d_1h_0m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 1, 1, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(1*60)

func when_time_data_is_0y_SUM_1d_23h_59m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 1, 23, 59)
	assert_float(time_system.convert_to_time(time_data)).is_equal(23*60 + 59)

func when_time_data_is_0y_SUM_2d_0h_0m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 2, 0, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(1*24*60)

func when_time_data_is_0y_SUM_3d_0h_0m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 3, 0, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(2*24*60)

func when_time_data_is_0y_SUM_28d_23h_59m():
	var time_data = _create_time_data(0, Consts.SEASON.SUMMER, 28, 23, 59)
	assert_float(time_system.convert_to_time(time_data)).is_equal(27*24*60 + 23*60 + 59)

func when_time_data_is_0y_AUT_1d_0h_0m():
	var time_data = _create_time_data(0, Consts.SEASON.AUTUMN, 1, 0, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(1*28*24*60)

func when_time_data_is_0y_SPR_28d_23h_59m():
	var time_data = _create_time_data(0, Consts.SEASON.SPRING, 28, 23, 59)
	assert_float(time_system.convert_to_time(time_data)).is_equal(3*28*24*60 + 27*24*60 + 23*60 + 59)

func when_time_data_is_1y_SUM_1d_0h_0m():
	var time_data = _create_time_data(1, Consts.SEASON.SUMMER, 1, 0, 0)
	assert_float(time_system.convert_to_time(time_data)).is_equal(4*28*24*60)

func when_time_data_is_100y_SPR_28d_23h_59m():
	var time_data = _create_time_data(100, Consts.SEASON.SPRING, 28, 23, 59)
	assert_float(time_system.convert_to_time(time_data)).is_equal(100*4*28*24*60 + 3*28*24*60 + 27*24*60 + 23*60 + 59)


func _create_time_data(year: int, season: int, day: int, hour: int, minute: int) -> TimeData:
	var time_data := TimeData.new()
	time_data.year = year
	time_data.season = season
	time_data.day = day
	time_data.hour = hour
	time_data.minute = minute
	return time_data
