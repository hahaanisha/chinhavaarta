import cv2
from cvzone.HandTrackingModule import HandDetector
import numpy as np
import math
import time

# Initialize video capture
cap = cv2.VideoCapture(0)
detector = HandDetector(maxHands=2)  # Detect up to 2 hands

# Configuration parameters
offset = 50  # Increased offset to capture more area
imgSize = 300
folder = "Letters/U"
counter = 0

while True:
    # Read frame from camera
    success, img = cap.read()
    
    # Detect hands
    hands, img = detector.findHands(img)
    
    # Process hands if detected
    if hands and len(hands) > 0:
        # If multiple hands are detected, find the encompassing bounding box
        if len(hands) > 1:
            # Find the minimum x, minimum y, maximum width, and maximum height
            min_x = min(hand['bbox'][0] for hand in hands)
            min_y = min(hand['bbox'][1] for hand in hands)
            max_x = max(hand['bbox'][0] + hand['bbox'][2] for hand in hands)
            max_y = max(hand['bbox'][1] + hand['bbox'][3] for hand in hands)
            
            # Calculate width and height of the combined bounding box
            w = max_x - min_x
            h = max_y - min_y
            x = min_x
            y = min_y
        else:
            # If only one hand, use its bounding box
            x, y, w, h = hands[0]['bbox']
        
        # Create white canvas
        imgWhite = np.ones((imgSize, imgSize, 3), np.uint8) * 255
        
        # Crop the hand region with increased offset
        imgCrop = img[max(0, y - offset):y + h + offset, 
                      max(0, x - offset):x + w + offset]
        
        # Check if crop is valid
        if imgCrop.size > 0:
            # Calculate aspect ratio
            aspectRatio = h / w
            
            # Resize and center the image
            if aspectRatio > 1:
                # Height is larger than width
                k = imgSize / h
                wCal = math.ceil(k * w)
                imgResize = cv2.resize(imgCrop, (wCal, imgSize))
                wGap = math.ceil((imgSize - wCal) / 2)
                imgWhite[:, wGap:wCal + wGap] = imgResize
            else:
                # Width is larger than height
                k = imgSize / w
                hCal = math.ceil(k * h)
                imgResize = cv2.resize(imgCrop, (imgSize, hCal))
                hGap = math.ceil((imgSize - hCal) / 2)
                imgWhite[hGap:hCal + hGap, :] = imgResize
            
            # Display the processed image
            cv2.imshow("ImageWhite", imgWhite)
    
    # Display original image
    cv2.imshow("Image", img)
    
    # Key handling
    key = cv2.waitKey(1)
    
    # Save image when 's' is pressed
    if key == ord("s") and hands:
        counter += 1
        filename = f'{folder}/Image_{time.time()}.jpg'
        cv2.imwrite(filename, imgWhite)
        print(f"Saved {filename}")
    
    # Exit on ESC key
    if key == 27:  # ESC key
        break

# Cleanup
cap.release()
cv2.destroyAllWindows()