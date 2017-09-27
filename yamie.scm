(define (auto-yamie avatar-path output-path)
  (define img (vector-ref (cadr (gimp-image-list)) 0)) ; We're editing the current image
  (define layer (car (gimp-file-load-layer 0 img avatar-path))) ; Load avatar as a layer
  (gimp-image-insert-layer img layer 0 -1) ; Insert the layer into the current image
  (gimp-layer-scale layer 150 150 1) ; Scale the layer
  (define mask (car (gimp-layer-create-mask layer 1))) ; Create a transparent mask
  (gimp-layer-add-mask layer mask) ; Add the mask to the layer
  (gimp-layer-set-offsets layer 96 355) ; Move the layer
  (gimp-context-set-foreground '(255 255 255)) ; Set foreground color for use with the bucket fill tool
  (gimp-edit-bucket-fill mask 0 0 100 0 1 75 75) ; Fill the mask (make it visible)
  (gimp-image-merge-visible-layers img CLIP-TO-BOTTOM-LAYER) ; Merge layers
  (gimp-file-save 1 img (car (gimp-image-get-active-layer img)) output-path "")) ; Save the final result
