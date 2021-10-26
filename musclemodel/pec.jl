## parallel elastic component
# passive joint torques from Reiner and Edrich (1999)

# convert model joint angles to joint angle definitions from paper
convertHip(θ) = rad2deg(π - θ)
convertKnee(θ) = rad2deg(π - θ)
convertAnkle(θ) = rad2deg(θ - (π / 2))

# passive torques
torqueHip(ϕh, ϕk) = ℯ^(1.4655 - .0034ϕk - .075ϕh)  - ℯ^(1.3403 - .0226ϕk + .0305ϕh) + 8.072
torqueKnee(ϕh, ϕk, ϕa) = ℯ^(1.8 - .046ϕa - .0352ϕk + .0217ϕh) - ℯ^(-3.971 - .0004ϕa + .0495ϕk - .0128ϕh) - 4.82 + ℯ^(2.22 - .15ϕk)
torqueAnkle(ϕk, ϕa) = ℯ^(2.1016 - .0843ϕa - .0176ϕk) - ℯ^(-7.9763 + .1949ϕa + .0008ϕk) - 1.792


function PEtorque(θh, θk, θa)
    # convert to match joint angle definitions
    ϕh = convertHip(θh)
    ϕk = convertKnee(θk)
    ϕa = convertAnkle(θa)

    # calculate passive torques
    τh = torqueHip(ϕh, ϕk)
    τk = torqueKnee(ϕh, ϕk, ϕa)
    τa = torqueAnkle(ϕk, ϕa)

    return τh, τk, τa
end