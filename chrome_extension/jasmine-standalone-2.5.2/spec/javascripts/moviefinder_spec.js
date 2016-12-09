// MovieFinder covers all 

describe('MovieFinder', ()=>{
  it('searches for a movie and returns json', ()=>{
    expect(typeof MovieFinder.search('the thing')).toBe('object');
  });
});


// describe('NOEx', () => {
//   beforeEach(function(){
//     loadFixtures('popup_spec.html');
//   });
//   NOEx.loadData({
//     "context": "Presidental",
//     "names": [
//       "Donald Trump",
//       "Mike Pence"
//     ]
//   });

//   it('loads the names', () => {
//     expect(NOEx.names.length).toBe(2);
//   });

//   it('shows the names in the pop-up', () => {
//     NOEx.showNames();
    
//     expect($('.context').text()).toBe('Presidental')
//     expect($('.name').length).toBe(2);
//   });
// });