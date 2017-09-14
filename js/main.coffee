---
---

app      = document.querySelector('.app')
picture  = app.querySelector('.picture')
title    = app.querySelector('.title')
question = app.querySelector('.question')
options  = app.querySelector('.options')
feedback = app.querySelector('.feedback')
controls = app.querySelector('.controls')
step     = 0
qIndex   = 0
quizActive = false

tick = (msg) ->
    console.log msg
    msg

$el = (element, attrs, events) ->
    el = document.createElement element
    el[key] = val for key, val of attrs if attrs
    el.addEventListener key, val for key, val of events if events
    el

getStep = (i) ->
    return false if i >= quiz.length
    step = i or 0
    quiz[step]

getNextStep = ->
    getStep step + 1

getQuestion = (i) ->
    return false if i >= quiz[step].questions.length
    qIndex = i or 0
    quiz[step].questions[qIndex]

getNextQuestion = ->
    getQuestion qIndex + 1

answerQuestion = (isRight) ->
    feedback.innerHTML = if isRight then "<p>Parabéns! Esta é a resposta certa.</p>" else "<p>Não! Que pena... Você não acertou.</p>"
    nextQuestion = getNextQuestion()
    if nextQuestion
        controls.appendChild $el 'button', {
            innerHTML: 'Próxima pergunta'
        }, {
            click: (e) ->
                outputQuestion nextQuestion
        }
    else
        controls.appendChild $el 'button', {
            innerHTML: 'Avançar'
        }, {
            click: (e) ->
                nextStep = getNextStep()
                if nextStep
                    setStep nextStep
                else
                    endQuiz()
        }

outputQuestion = (q) ->
    question.innerHTML = "<p>#{q.question}</p>"
    options.innerHTML = ""
    feedback.innerHTML = ""
    controls.innerHTML = ""
    quizActive = true
    q.alts.forEach (alt) ->
        options.appendChild $el 'button', {
            innerHTML: alt.answer
        }, {
            click: (e) ->
                return if not quizActive
                answerQuestion alt.right
                this.classList.add 'active'
                quizActive = false
        }

setStep = (q) ->
    picture.src = "{{ site.baseurl }}/img/#{imgFolder}/#{q.id}.jpg"
    title.innerHTML = "<h2>#{q.title}<h2>"
    quizActive = true
    outputQuestion getQuestion()

endQuiz = ->
    console.log "Fim!"

setStep getStep()
