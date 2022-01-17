## function to find best ARIMA model
## p 144 of Cowpertwait 2009



get.best.arima <- function(x.ts, maxord = c(1,1,1,1,1,1))
{
   best.aic <- 1e8
   n <- length(x.ts)
   for (p in 0:maxord[1]) for(d in 0:maxord[2]) for(q in 0:maxord[3])
      for (P in 0:maxord[4]) for(D in 0:maxord[5]) for(Q in 0:maxord[6])
      {
         fit <- arima(x.ts, order = c(p,d,q),
                      seas = list(order = c(P,D,Q),12),
                      method = "CSS")
         fit.aic <- -2 * fit$loglik + (log(n) + 1) * length(fit$coef)
         if (fit.aic < best.aic)
         {
            best.aic <- fit.aic
            best.fit <- fit
            best.model <- c(p,d,q,P,D,Q)
         }
      }
   list(best.aic, best.fit, best.model)
}

get.best.arima.d0 <- function(x.ts, maxord = c(1,1,1,1))
{
   best.aic <- 1e8
   n <- length(x.ts)
   for (p in 0:maxord[1]) for(q in 0:maxord[2])
      for (P in 0:maxord[3]) for(Q in 0:maxord[4])
      {
         fit <- arima(x.ts, order = c(p,0,q),
                      seas = list(order = c(P,0,Q),12),
                      method = "CSS")
         fit.aic <- -2 * fit$loglik + (log(n) + 1) * length(fit$coef)
         if (fit.aic < best.aic)
         {
            best.aic <- fit.aic
            best.fit <- fit
            best.model <- c(p,q,P,Q)
         }
      }
   list(best.aic, best.fit, best.model)
}


