package api

// contextKey avoids collisions
//
// const userKey = contextKey("authenticated-user")
//
// func ContextWithUser(ctx context.Context, user *auth.Payload) context.Context {
// 	return context.WithValue(ctx, userKey, user)
// }
//
// func UserFromContext(ctx context.Context) (*auth.Payload, bool) {
// 	u, ok := ctx.Value(userKey).(*auth.Payload)
// 	return u, ok
// }
//
// // AuthMiddleware parses token from header or cookie and adds user to context
// func AuthMiddleware(verifyToken func(token string) (*auth.Payload, error)) func(http.Handler) http.Handler {
// 	return func(next http.Handler) http.Handler {
// 		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
// 			// 1. Extract token (header or cookie)
// 			var token string
//
// 			// Try Authorization: Bearer ...
// 			authHeader := r.Header.Get("Authorization")
// 			if strings.HasPrefix(authHeader, "Bearer ") {
// 				token = strings.TrimPrefix(authHeader, "Bearer ")
// 			}
//
// 			// Or fallback to cookie (e.g., refresh_token or session_token)
// 			if token == "" {
// 				if cookie, err := r.Cookie("access_token"); err == nil {
// 					token = cookie.Value
// 				}
// 			}
//
// 			if token == "" {
// 				http.Error(w, "unauthenticated", http.StatusUnauthorized)
// 				return
// 			}
//
// 			// 2. Validate token (custom logic)
// 			user, err := verifyToken(token)
// 			if err != nil {
// 				http.Error(w, "invalid token", http.StatusUnauthorized)
// 				return
// 			}
//
// 			// 3. Inject user into context
// 			ctx := ContextWithUser(r.Context(), user)
//
// 			// 4. Continue
// 			next.ServeHTTP(w, r.WithContext(ctx))
// 		})
// 	}
// }
