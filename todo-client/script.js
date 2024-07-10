const dateTimeItem = document.querySelectorAll('.item')
const btnAdd = document.querySelector('.add')
const addForm = document.querySelector('.add-container')
const closeBtn = document.querySelector('#closeBtn')
const listItem = document.querySelector('.listItem')
const savebtn = document.querySelector('#savebtn')

const todoItems = [
    {
        id: 2,
        title: "Title 2",
        decription: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem, dolores reprehenderit officia minus voluptates similique blanditiis pariatur nulla repudiandae nostrum.",
        completed: false
    }
]

const showItems = () => {
    listItem.innerHTML = ''
    if (todoItems.length > 0) {
        todoItems.map(itm => {
            const listDiv = document.createElement('div')
            const lcdiv = document.createElement('div')
            const span = document.createElement('span')
            const input = document.createElement('input')
            const descDiv = document.createElement('div')

            descDiv.textContent = itm.decription
            span.textContent = itm.title
            input.setAttribute('value', itm.id)

            input.setAttribute('type', 'checkbox')
            input.setAttribute('id', 'checkbox')
            listDiv.setAttribute('class', 'list')
            lcdiv.setAttribute('class', 'lcdiv')
            descDiv.setAttribute('class', 'descDiv')

            lcdiv.appendChild(span)
            lcdiv.appendChild(input)
            listDiv.appendChild(lcdiv)
            listDiv.appendChild(descDiv)
            listItem.appendChild(listDiv)
            
            if (itm.completed == true) {
                span.style.textDecoration = 'line-through'
                input.checked = true
            } else {
                span.style.textDecoration = 'none'
                input.checked = false
            }
        })


        document.querySelectorAll('.list').forEach(list => {
            list.addEventListener('click', (e) => {
                const trgt = e.target.nextSibling.classList
                const dll = trgt[1]
                const found = document.querySelector('.list .OPEN')
                if (found != null) found.classList.remove('OPEN');

                if (dll == undefined) e.target.nextSibling.classList.add('OPEN');

                console.dir(e.target.nextSibling)
            })
        })


        document.querySelectorAll('#checkbox').forEach(item => {
            item.addEventListener('change', (e) => {
                const { value, checked } = e.target
                const indexNum = todoItems.findIndex(i => i.id == value)
                if (checked) {
                    const updatedObj = { ...todoItems[indexNum], completed: true }
                    todoItems[indexNum] = updatedObj
                } else {
                    const updatedObj = { ...todoItems[indexNum], completed: false }
                    todoItems[indexNum] = updatedObj
                }
                showItems()
            })
        })
    }
}
const addItem = () => {
    const title = document.querySelector('#item').value
    const Description = document.querySelector('#Description').value;
    const newObj = {}
    newObj.id = Math.floor(Math.random() * 100000)
    newObj.title = title
    newObj.decription = Description
    newObj.completed = false
    todoItems.push(newObj)
    showItems()

}
savebtn.addEventListener('click', () => {
    addItem()
    document.querySelector('#item').value = ''
    addForm.style.transform = 'scale(0)'
})
btnAdd.addEventListener('click', () => {
    addForm.style.transform = 'scale(1)'
})
closeBtn.addEventListener('click', () => {
    addForm.style.transform = 'scale(0)'
})
showItems()