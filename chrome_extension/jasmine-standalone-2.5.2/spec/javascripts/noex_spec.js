// describe('Add should add', () => {
//   it('should add two numbers together', () => {
//     expect(add(1,2)).toBe(3);
//   });
// });


describe('NOEx', () => {
  beforeEach(function(){
    loadFixtures('popup_spec.html');
  });
  NOEx.loadData({
    "context": "Presidental",
    "names": [
      "Donald Trump",
      "Mike Pence"
    ]
  });

  it('loads the names', () => {
    expect(NOEx.names.length).toBe(2);
  });

  it('shows the names in the pop-up', () => {
    NOEx.showNames();
    
    expect($('.context').text()).toBe('Presidental')
    expect($('.name').length).toBe(2);
  });
});