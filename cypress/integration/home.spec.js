describe("Visiting the homepage", () => {
  it("should visit the homepage after logging in", () => {
  // visit the login page
  cy.visit("http://localhost:3000", { failOnStatusCode: false });
  });
  
  it("There are products on the page", () => {
  cy.get(".products article").should("be.visible");
  });
  
  it("There are 12 products on the page", () => {
  cy.get(".products article").should("have.length", 12);
  });
});