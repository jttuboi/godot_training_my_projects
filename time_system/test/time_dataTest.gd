#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name time_dataTest
extends GdUnitTestSuite

const __source = 'res://src/time_data.gd'

var time


func before():
	time = load(__source).new()


func test_get_weekday_min_str():
	time.weekday = Consts.WEEKDAY.MONDAY
	assert_str(time.get_weekday_min_str()).is_equal('MON')
	time.weekday = Consts.WEEKDAY.TUESDAY
	assert_str(time.get_weekday_min_str()).is_equal('TUE')
	time.weekday = Consts.WEEKDAY.WEDNESDAY
	assert_str(time.get_weekday_min_str()).is_equal('WED')
	time.weekday = Consts.WEEKDAY.THURSDAY
	assert_str(time.get_weekday_min_str()).is_equal('THU')
	time.weekday = Consts.WEEKDAY.FRIDAY
	assert_str(time.get_weekday_min_str()).is_equal('FRI')
	time.weekday = Consts.WEEKDAY.SATURDAY
	assert_str(time.get_weekday_min_str()).is_equal('SAT')
	time.weekday = Consts.WEEKDAY.SUNDAY
	assert_str(time.get_weekday_min_str()).is_equal('SUN')


func test_get_weekday_full_str():
	time.weekday = Consts.WEEKDAY.MONDAY
	assert_str(time.get_weekday_full_str()).is_equal('MONDAY')
	time.weekday = Consts.WEEKDAY.TUESDAY
	assert_str(time.get_weekday_full_str()).is_equal('TUESDAY')
	time.weekday = Consts.WEEKDAY.WEDNESDAY
	assert_str(time.get_weekday_full_str()).is_equal('WEDNESDAY')
	time.weekday = Consts.WEEKDAY.THURSDAY
	assert_str(time.get_weekday_full_str()).is_equal('THURSDAY')
	time.weekday = Consts.WEEKDAY.FRIDAY
	assert_str(time.get_weekday_full_str()).is_equal('FRIDAY')
	time.weekday = Consts.WEEKDAY.SATURDAY
	assert_str(time.get_weekday_full_str()).is_equal('SATURDAY')
	time.weekday = Consts.WEEKDAY.SUNDAY
	assert_str(time.get_weekday_full_str()).is_equal('SUNDAY')


func test_get_season_min_str():
	time.season = Consts.SEASON.SUMMER
	assert_str(time.get_season_min_str()).is_equal('SUM')
	time.season = Consts.SEASON.AUTUMN
	assert_str(time.get_season_min_str()).is_equal('AUT')
	time.season = Consts.SEASON.WINTER
	assert_str(time.get_season_min_str()).is_equal('WIN')
	time.season = Consts.SEASON.SPRING
	assert_str(time.get_season_min_str()).is_equal('SPR')


func test_get_season_full_str():
	time.season = Consts.SEASON.SUMMER
	assert_str(time.get_season_full_str()).is_equal('SUMMER')
	time.season = Consts.SEASON.AUTUMN
	assert_str(time.get_season_full_str()).is_equal('AUTUMN')
	time.season = Consts.SEASON.WINTER
	assert_str(time.get_season_full_str()).is_equal('WINTER')
	time.season = Consts.SEASON.SPRING
	assert_str(time.get_season_full_str()).is_equal('SPRING')


func test_is_equal_time_id():
	when_time_id_is_equals()
	when_time_id_is_different()

func when_time_id_is_equals():
	time.year = 456
	time.season = Consts.SEASON.WINTER
	time.day = 8
	time.hour = 10
	time.minute = 12
	assert_bool(time.is_equal_time_id('456yWINs08d10h12m')).is_true()

func when_time_id_is_different():
	time.year = 456
	time.season = Consts.SEASON.WINTER
	time.day = 8
	time.hour = 10
	time.minute = 12
	assert_bool(time.is_equal_time_id('000ySUMs01d00h00m')).is_false()


func test__get_time_id():
	time.year = 123
	time.season = Consts.SEASON.AUTUMN
	time.day = 14
	time.hour = 12
	time.minute = 30
	assert_str(time._get_time_id()).is_equal('123yAUTs14d12h30m')


func test_set_by_time_id():
	time.set_by_time_id('999ySPRs28d23h59m')
	assert_int(time.year).is_equal(999)
	assert_int(time.season).is_equal(Consts.SEASON.SPRING)
	assert_int(time.day).is_equal(28)
	assert_int(time.hour).is_equal(23)
	assert_int(time.minute).is_equal(59)
	assert_int(time.weekday).is_equal(Consts.WEEKDAY.SUNDAY)


func test__check_time_id_valid():
	when_time_id_has_inconsistent_length()
	when_time_id_has_inconsistent_year()
	when_time_id_has_consistent_year()
	when_time_id_has_inconsistent_season()
	when_time_id_has_consistent_season()
	when_time_id_has_inconsistent_day()
	when_time_id_has_consistent_day()
	when_time_id_has_inconsistent_hour()
	when_time_id_has_consistent_hour()
	when_time_id_has_inconsistent_minute()
	when_time_id_has_consistent_minute()

func when_time_id_has_inconsistent_length():
	assert_bool(time._check_time_id_valid('')).is_false()
	assert_bool(time._check_time_id_valid('123456789012345678')).is_false()
	
func when_time_id_has_inconsistent_year():
	assert_bool(time._check_time_id_valid('00aySUMs01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('0-0ySUMs01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid(' 00ySUMs01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000sSUMs01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('-10sSUMs01d00h00m')).is_false()
	
func when_time_id_has_consistent_year():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('001ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('999ySUMs01d00h00m')).is_true()
	
func when_time_id_has_inconsistent_season():
	assert_bool(time._check_time_id_valid('000y000s01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000y0-0s01d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMw01d00h00m')).is_false()
	
func when_time_id_has_consistent_season():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000yAUTs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000yWINs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySPRs01d00h00m')).is_true()
	
func when_time_id_has_inconsistent_day():
	assert_bool(time._check_time_id_valid('000ySUMs-1d00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs0xd00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01x00h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs29d00h00m')).is_false()
	
func when_time_id_has_consistent_day():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs14d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs28d00h00m')).is_true()
	
func when_time_id_has_inconsistent_hour():
	assert_bool(time._check_time_id_valid('000ySUMs01d0xh00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d-1h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d24h00m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d00x00m')).is_false()
	
func when_time_id_has_consistent_hour():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs01d12h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs01d23h00m')).is_true()
	
func when_time_id_has_inconsistent_minute():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h0xm')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d00h-1m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d00h60m')).is_false()
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00x')).is_false()
	
func when_time_id_has_consistent_minute():
	assert_bool(time._check_time_id_valid('000ySUMs01d00h00m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs01d00h30m')).is_true()
	assert_bool(time._check_time_id_valid('000ySUMs01d00h59m')).is_true()
