extends Node

var time := 0.0

var _game_speed = 300#300 #60 # 1
var _previous_minute: int
var _previous_year: int


func _ready():
	time = 6*60 # start 0y SUM 1d 6h 0m
	_previous_minute = time
	_previous_year = 0


func _physics_process(delta: float):
	time += delta * _game_speed
	
	var current_minute = get_minute()
	if _previous_minute != current_minute:
		_previous_minute = current_minute
		
		var time = _create_time()
		Signals.emit_signal('minute_changed', time)
		
		if time.minute == 0:
			Signals.emit_signal('hour_changed', time)
			if time.hour == 0:
				Signals.emit_signal('day_changed', time)
				match time.day:
					1, 8, 15, 22:
						Signals.emit_signal('weekday_changed', time)
				if time.day == 1:
					Signals.emit_signal('season_changed', time)
					if _previous_year != time.year:
						Signals.emit_signal('year_changed', time)
						_previous_year = time.year


# 0m .. 59m
func get_minute() -> int:
	return int(time) % 60


# 0h .. 23h
func get_hour() -> int:
	return int(time / Times.TIME_HOUR) % 24


# 1d .. 28d
func get_day() -> int:
	return (int(time / Times.TIME_DAY) % 28) + 1


# 0 = MON, 1 = TUE, 2 = WED, 3 = THU, 4 = FRI, 5 = SAT, 6 = SUN
func get_weekday() -> int:
	return int(time / Times.TIME_DAY) % 7


# 0 = SUMMER, 1 = AUTUMN, 2 = WINTER, 3 = SPRING
func get_season() -> int:
	return int(time / Times.TIME_SEASON) % 4


# 0y, 1y, 2y ..
func get_year() -> int:
	return int(time / Times.TIME_YEAR)


func convert_to_time(time_data: TimeData) -> float:
	return float(time_data.year*Times.TIME_YEAR + time_data.season*Times.TIME_SEASON + (time_data.day - 1)*Times.TIME_DAY + time_data.hour*Times.TIME_HOUR + time_data.minute)


func _create_time() -> TimeData:
	var time = TimeData.new()
	time.year = get_year()
	time.season = get_season()
	time.weekday = get_weekday()
	time.day = get_day()
	time.hour = get_hour()
	time.minute = get_minute()
	return time
