function fcns_fn(x, constants, variables, specifieds)
    name = string(x.args[1])
    vars = join(variables, ", ")
    params = join(uses(x, constants), ", ")
    specs = uses(x, specifieds)
    specs_bool = !isempty(specs)
    # specs_eqs = join(map(x -> "$x = $x(t)", split(specs, ", ")), "; ")
    equation = string(x.args[2])


    """function $name(sol, t)
        $( isempty(params) ? "" : "@unpack z, $params = sol.prob.p" )
        @inbounds $vars = sol(t)
        $(join(specs, ", ")) $(specs_bool ? "=" : "") $(join("_" .* String.(specs) .* "(t)", ", ") )

        # set z array values
        eom(SA[$vars],sol.prob.p,t)
        io(sol, t)

        return $equation
    end
    
    $name(sol) = [$name(sol,t) for t in sol.t]
    """
end

fcns_str = """# Automatically generated
           $(join([fcns_fn(x, constants, variables, specifieds) for x in io_as if !isZ(x.args[1])], "\n\n"))
           
           function io(sol, t)
            @unpack $(join(constants, ", "))$( isempty(z_as) ? "" : ", z") = sol.prob.p
            @inbounds $(join(variables, ", ")) = sol(t)

               # specified variables
               $( begin 
                   str = string.(uses(filter(x -> x.args[1] isa Expr && x.args[1].args[1] in [:z, :coef, :rhs], eqns_as), specifieds)) .|>
                   x -> "$x = _$x(t)"
                   join(str, "; ")
               end)

               # calculated variables
               lrx1, lry1, lrx2, lry2, rrx1, rry1, rrx2, rry2 = contact_forces(sol(t), p, t)

               $( join(const_as, "\n"))
               $( join(filter(assignZ, io_as), "\n") )
           
           end
                          
                      
           """

#    $( isempty(specs) ? "" : specs_eqs )
#    $( isempty(specs) ? "" : "@unpack $specs = sol.prob.p" )
