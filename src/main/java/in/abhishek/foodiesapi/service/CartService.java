package in.abhishek.foodiesapi.service;

import in.abhishek.foodiesapi.io.CartRequest;
import in.abhishek.foodiesapi.io.CartResponse;

public interface CartService {

    CartResponse addToCart(CartRequest request);

    CartResponse getCart();

    void clearCart();

    CartResponse removeFromCart(CartRequest cartRequest);
}
