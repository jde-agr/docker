# ----- Notes -----------------------------------------------------------------
# ft-rails:on-build needs to be an existing image first
# Everything starting with ONBUILD in that image's dockerfile  will run right
# after the FROM
# 's' is an alias for 'server', so I substituted it to be clearer
# -b binds an IP address
# -p specifies port
#
# Also fuck this exercise. I'm done.
# -----------------------------------------------------------------------------

FROM ft-rails:on-build
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
