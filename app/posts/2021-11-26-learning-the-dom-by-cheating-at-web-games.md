answer = $$('.card span').reduce((out, c, i) => {
   if(out[c.textContent]) {
     out[c.textContent] = [...out[c.textContent], i+1]
   } else {
     out[c.textContent] = [i+1];
   }
   return out;
}, {})

answer = $$('.card span').reduce((out, c, i) => {
  out[c.textContent] = [...(out[c.textContent] || []), i+1]
  return out;
}, {})

{
    "🐯": [
        1,
        9
    ],
    "🐵": [
        2,
        7
    ],
    "🐼": [
        3,
        8
    ],
    "🐶": [
        4,
        12
    ],
    "🐭": [
        5,
        11
    ],
    "🐱": [
        6,
        16
    ],
    "🐹": [
        10,
        14
    ],
    "🐻": [
        13,
        15
    ]
}

Object.values(answer).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});

Object.values($$('.card span').reduce((out, c, i) => {
   if(out[c.textContent]) {
     out[c.textContent] = [...out[c.textContent], i+1]
   } else {
     out[c.textContent] = [i+1];
   }
   return out;
}, {})).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});

Object.values($$('.card span').reduce((out, c, i) => {
  out[c.textContent] = [...(out[c.textContent] || []), i+1]
  return out;
}, {})).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});