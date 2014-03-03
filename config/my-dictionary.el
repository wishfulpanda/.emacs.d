;;; Site   : cevir.im
;;; Input  : http://cevir.ws/v1?q=apple&m=5&p=exact&l=all
;;; Output : {
;;;            "control": {
;;;              "status": "ok",
;;;              "message": "",
;;;              "results": 1
;;;            },
;;;            "word": [
;;;              {
;;;                "lang": "en",
;;;                "uid": "en6bi",
;;;                "title": "apple",
;;;                "desc": "(i). elma. apple blossom elma   baharı. apple butter elma marmelâdı. apple   green elma yaprağı renginde. applejack (i). elma rakısı. apple juice elma suyu. apple   of discord (mit). kavga tanrıçası tarafından   tanrılara atılan ve Paris tarafından Venüs e   hediye edilen elma. apple of the eve gözbebeği, çok değer verilen bir şey. in apple-pie order çok düzenli. apple polisher A.B.D., argo dalkavak, slang yağcı. applesauce (i). elma püresi;  (k) dili saçma, boş laf. Adam's apple (anat) Ademelması, gırtlak çıkıntısı. bitter apple hanzal, ithiyarı, (bot). Citrullus colocynthis. upset the apple cart pişmiş aşa soğuk su katmak, bir işi bozmak."
;;;              }
;;;            ]
;;;          }

(require 'url)
(require 'json)

(defun my-dictionary-search (search-term)
  "Search cevir.ws for SEARCH-TERM, returning the results as a Lisp structure."
  (let ((a-url (format "http://cevir.ws/v1?q=%s&m=5&p=exact&l=all" search-term)))
    (with-current-buffer
	(url-retrieve-synchronously a-url)
      (goto-char url-http-end-of-headers)
      (json-read))))

(defun get-description (response)
  "Extract the definition of the search term from the Lisp structure."
  (let ((word (cdr (assoc 'word response))))
     (cdr (assoc 'desc (elt word 0)))))

(defun my-dictionary ()
  "Get the search term from the user, search it in the cevir.ws and print the description."
  (interactive)
  (let ((search-term (read-string "Search: ")))
    (print (get-description (my-dictionary-search search-term)))))

(provide 'my-dictionary)
