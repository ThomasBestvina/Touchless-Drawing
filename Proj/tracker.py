from godot import exposed, export
from godot import *
import cv2
import mediapipe as mp
import threading

@exposed
class tracker(Node):
	def _ready(self):
		self.body_image = []
		def to_arr_dict(landmarks):
			if(landmarks is not None):
				mp_drawing = mp.solutions.drawing_utils
				mp_drawing_styles = mp.solutions.drawing_styles
				mp_hands = mp.solutions.hands
				self.body_image = []
				count = 0
				for data_point in landmarks:
					tempArr = []
					tempArr.append([data_point.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x,data_point.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y,data_point.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].z])
					tempArr.append([data_point.landmark[mp_hands.HandLandmark.THUMB_TIP].x,data_point.landmark[mp_hands.HandLandmark.THUMB_TIP].y,data_point.landmark[mp_hands.HandLandmark.THUMB_TIP].z])
					tempArr.append([data_point.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].x,data_point.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y,data_point.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].z])
					tempArr.append([data_point.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].x,data_point.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y,data_point.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].z])
					tempArr.append([data_point.landmark[mp_hands.HandLandmark.PINKY_TIP].x,data_point.landmark[mp_hands.HandLandmark.PINKY_TIP].x,data_point.landmark[mp_hands.HandLandmark.PINKY_TIP].z])
					self.body_image.append(tempArr)
		def tracker():
			mp_drawing = mp.solutions.drawing_utils
			mp_drawing_styles = mp.solutions.drawing_styles
			mp_hands = mp.solutions.hands
			cap = cv2.VideoCapture(0)
			with mp_hands.Hands(
				model_complexity=1,
				min_detection_confidence=0.5,
				min_tracking_confidence=0.5) as hands:
				while cap.isOpened():
					success, image = cap.read()
					if not success:
						cap.release()
						print("Ignoring empty camera frame.")
						# If loading a video, use 'break' instead of 'continue'.
						continue

					# To improve performance, optionally mark the image as not writeable to
					# pass by reference.
					image.flags.writeable = False
					image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
					results = hands.process(image)

					# Draw the hand annotations on the image.
					image.flags.writeable = True
					image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
					if results.multi_hand_landmarks:
						count = 0
						for hand_landmarks in results.multi_hand_landmarks:
							count += 1
							mp_drawing.draw_landmarks(
								image,
								hand_landmarks,
								mp_hands.HAND_CONNECTIONS,
								mp_drawing_styles.get_default_hand_landmarks_style(),
								mp_drawing_styles.get_default_hand_connections_style())
						to_arr_dict(results.multi_hand_landmarks)
					
					# Flip the image horizontally for a selfie-view display.
					cv2.imshow('MediaPipe Hands', cv2.flip(image, 1))
					if cv2.waitKey(5) & 0xFF == 27:
					  break
			cap.release()
		thread = threading.Thread(target=tracker)#, daemon=True)
		thread.start()
	def update_hand(self,hand,finger,pos):
		if(self.body_image):
			return(self.body_image[hand][finger][pos])
		else:
			return(0)
