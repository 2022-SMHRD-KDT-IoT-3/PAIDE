package Service;

public class envCheckService {
	// {(0)낮최고온도,(1)낮최저온도,(2)밤최고온도,(3)낮최고온도,(4)낮최고습도,(5)낮최저습도,(6)밤최고습도,(7)밤최저습도}
			private int tomato[] = { 30, 25, 25, 13, 85, 60, 85, 60 }; 
			private int paprika[] = { 30, 21, 25, 15, 85, 60, 85, 60 };
			private int strawberry[] = { 25, 10, 22, 8, 85, 65, 95, 85 };
			private int cucumber[] = { 28, 22, 20, 15, 80, 60, 80, 60 };
			
			// 0 정상, 1 높음, 2 낮음
			private int t_check = 0; 
			private int h_check = 0;
			
			public envCheckService() {
				
			}
			
			public String envCheck(String crop, int hour, double temp, double humi) {
				if (crop.equals("토마토")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= tomato[0] && temp >= tomato[1] && humi <= tomato[2] && humi >= tomato[3]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					} else {
						if (temp <= tomato[4] && temp >= tomato[5] && humi <= tomato[6] && humi >= tomato[7]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					}
				} else if (crop.equals("파프리카")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= paprika[0] && temp >= paprika[1] && humi <= paprika[2] && humi >= paprika[3]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					} else {
						if (temp <= paprika[4] && temp >= paprika[5] && humi <= paprika[6] && humi >= paprika[7]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					}
				} else if (crop.equals("딸기")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= strawberry[0] && temp >= strawberry[1] && humi <= strawberry[2] && humi >= strawberry[3]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					} else {
						if (temp <= strawberry[4] && temp >= strawberry[5] && humi <= strawberry[6] && humi >= strawberry[7]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					}
				} else if (crop.equals("오이")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= cucumber[0] && temp >= cucumber[1] && humi <= cucumber[2] && humi >= cucumber[3]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					} else {
						if (temp <= cucumber[4] && temp >= cucumber[5] && humi <= cucumber[6] && humi >= cucumber[7]) {
							return "{\"LED\":\"1\"}";
						} else {
							return "{\"LED\":\"0\"}";
						}
					}
				} else {
					return "{\"LED\":\"0\"}";
				}
			}

			public String tempCheck(String crop, int hour, double temp) {

				String result = "";
				if (crop.equals("토마토")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= tomato[0] && temp >= tomato[1]) {
							t_check = 0;

						} else if (temp > tomato[0]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					} else {
						if (temp <= tomato[2] && temp >= tomato[3]) {
							t_check = 0;

						} else if (temp > tomato[2]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					}

				}
				if (crop.equals("파프리카")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= paprika[0] && temp >= paprika[1]) {
							t_check = 0;

						} else if (temp > paprika[0]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					} else {
						if (temp <= paprika[2] && temp >= paprika[3]) {
							t_check = 0;

						} else if (temp > paprika[2]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					}

				}
				if (crop.equals("딸기")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= strawberry[0] && temp >= strawberry[1]) {
							t_check = 0;

						} else if (temp > strawberry[0]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					} else {
						if (temp <= strawberry[2] && temp >= strawberry[3]) {
							t_check = 0;

						} else if (temp > strawberry[2]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					}

				}
				if (crop.equals("오이")) {
					if (hour >= 8 && hour <= 19) {
						if (temp <= cucumber[0] && temp >= cucumber[1]) {
							t_check = 0;

						} else if (temp > cucumber[0]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					} else {
						if (temp <= cucumber[2] && temp >= cucumber[3]) {
							t_check = 0;

						} else if (temp > cucumber[2]) {
							t_check = 1;
						} else {
							t_check = 2;
						}

					}

				}

				if (t_check == 0) {
					result = "정상";
				} else if (t_check == 1) {
					result = "높음";
				} else {
					result = "낮음";
				}
				return result;
			}

			public String humiCheck(String crop, int hour, double humi) {
				String result = "";
				if (crop.equals("토마토")) {
					if (hour >= 8 && hour <= 19) {
						if (humi <= tomato[4] && humi >= tomato[5]) {
							h_check = 0;

						} else if (humi > tomato[4]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					} else {
						if (humi <= tomato[6] && humi >= tomato[7]) {
							h_check = 0;

						} else if (humi > tomato[6]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					}

				}
				if (crop.equals("파프리카")) {
					if (hour >= 8 && hour <= 19) {
						if (humi <= paprika[4] && humi >= paprika[5]) {
							h_check = 0;

						} else if (humi > paprika[4]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					} else {
						if (humi <= paprika[6] && humi >= paprika[7]) {
							h_check = 0;

						} else if (humi > paprika[6]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					}

				}
				if (crop.equals("딸기")) {
					if (hour >= 8 && hour <= 19) {
						if (humi <= strawberry[4] && humi >= strawberry[5]) {
							h_check = 0;

						} else if (humi > strawberry[4]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					} else {
						if (humi <= strawberry[6] && humi >= strawberry[7]) {
							h_check = 0;

						} else if (humi > strawberry[6]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					}

				}
				if (crop.equals("오이")) {
					if (hour >= 8 && hour <= 19) {
						if (humi <= cucumber[4] && humi >= cucumber[5]) {
							h_check = 0;

						} else if (humi > cucumber[4]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					} else {
						if (humi <= cucumber[6] && humi >= cucumber[7]) {
							h_check = 0;

						} else if (humi > cucumber[6]) {
							h_check = 1;
						} else {
							h_check = 2;
						}

					}

				}

				if (h_check == 0) {
					result = "정상";
				} else if (h_check == 1) {
					result = "높음";
				} else {
					result = "낮음";
				}
				return result;
			}

}
