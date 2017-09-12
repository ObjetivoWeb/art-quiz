---
---

answers = 
    monalisa: "Sim"

isCorrect = (key, val) ->
    return if not key or not val
    val is answers[key]

q = document.querySelector('.app .question')
options = q.querySelectorAll('input')
feedback = q.querySelector('.feedback')

options.forEach (o) ->
    o.addEventListener 'click', (e) ->
        if isCorrect(q.id, e.target.value)
            feedback.innerHTML = '<p class="certo">Acertou. Parabéns!</p>'
        else
            feedback.innerHTML = '<p class="errado">Errou... que pena.</p>'
