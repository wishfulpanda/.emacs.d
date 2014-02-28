(defvar alarm-clock-timer nil
  "Keep timer so that the user can cancel the alarm")

(defvar alarm-clock-time nil)
(defvar alarm-clock-message nil)

(defun alarm-clock-message (text)
  "The actual alarm action"
  (progn
    (let((i 0))
      (while (< i 2)
        (play-sound-file "/home/gokhan/Music/rooster-1.wav")
        (setq i (1+ i)))
      (message-box text))))

(defun alarm-clock ()
  "Set an alarm.
The time format is the same accepted by `run-at-time'.  For
example \"11:30am\"."
  (interactive)
  (let ((time (read-string "Time: "))
        (text (read-string "Alarm message: ")))
    (progn
      (setq alarm-clock-time time)
      (setq alarm-clock-message text)
      (setq alarm-clock-timer 
            (run-at-time time nil 'alarm-clock-message text)))))

(defun alarm-clock-info ()
  "Show the alarm-clock's info"
  (interactive)
  (if alarm-clock-time
      (message-box (format "time: %s  |  message: %s" alarm-clock-time alarm-clock-message)) 
    (message-box "Alarm is not set")))

(defun alarm-clock-cancel ()
  "Cancel the alarm clock"
  (interactive)
  (cancel-timer alarm-clock-timer))

(provide 'my-alarm-clock)
