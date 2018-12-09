PRO NODE__DEFINE
  void = {NODE, data:ptr_new(), next:obj_new(), prev:obj_new()}
  RETURN
END

FUNCTION NODE::INIT, value
  self.data = ptr_new(value)
  self.next = self
  self.prev = self
  return, 1
END

FUNCTION NODE::DATA
  return, *self.data
END

FUNCTION NODE::NEXT
  return, self.next
END

FUNCTION NODE::PREV
  return, self.prev
END

PRO NODE::DELETE_NEXT
  new_next = (self.next).next
  new_next.prev = self
  self.next = new_next
END

PRO NODE::INSERT, value
  m = OBJ_NEW('Node', value)
  old_next = self.next
  old_next.prev = m
  m.next = old_next
  m.prev = self
  self.next = m
END

PRO RUN, c, max
  s = OBJ_NEW('Node', 0)
  n = s
  scores = make_array(c, /l64)

  FOR i = 1, max DO BEGIN
    IF (i MOD 23) EQ 0 THEN BEGIN
      player = (i MOD c)
      FOR J = 1, 7 DO BEGIN
        n = n->prev()
      ENDFOR
      scores[player] += n->data() + I
      n = n->prev()
      n->delete_next
      n = n->next()
    ENDIF ELSE BEGIN
      n = n->next()
      n->insert, I
      n = n->next()
    ENDELSE
  ENDFOR

  print, max(scores)
END

PRO MAIN
  str = ''
  read, str
  parts = strsplit(str, ' ', /EXTRACT)
  c = long(parts[0])
  max = long(parts[6])
  run, c, max
  run, c, max*100
  exit, status=0
END


