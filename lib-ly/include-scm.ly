\version "2.18.2"

#(use-modules (ice-9 regex))
include-scm = #(define-void-function (parser location filename )(string?) 
  (let* ((source-filename (car (ly:input-both-locations location)))
		 (target-filename 
		   (regexp-substitute/global 
			 #f "[^/]*$"  
			 source-filename 'pre filename 'post)))

		(load target-filename)))
