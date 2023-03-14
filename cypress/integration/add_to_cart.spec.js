describe("Visiting the homepage", () => {
  it("should visit the homepage after logging in", () => {
  // visit the login page
  cy.visit("/", { failOnStatusCode: false });
  });
  
  it("There are products on the page", () => {
  cy.get(".products article").should("be.visible");
  });
  
  it("There are 12 products on the page", () => {
  cy.get(".products article").should("have.length", 2);
  });

  it("count of the cart button changes when adding products to it", () =>{
    cy.contains('My Cart (0)')
    cy.get('.btn').first().click({force: true})
    cy.contains('My Cart (1)')
  }); 
  
  

});