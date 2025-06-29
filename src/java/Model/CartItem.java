/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class CartItem {
    private int id;
    private Cart card;
    private ProductVariant variant;
    private int quantity;

    public CartItem() {
    }

    public CartItem( Cart card, ProductVariant variant, int quantity) {
        this.card = card;
        this.variant = variant;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cart getCard() {
        return card;
    }

    public void setCard(Cart card) {
        this.card = card;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "CartItems{" + "id=" + id + ", card=" + card + ", variant=" + variant + ", quantity=" + quantity + '}';
    }
    
}
