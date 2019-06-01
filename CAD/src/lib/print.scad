include <./copyFunctions.scad>

module print(draft = true, position = [0, 0, 0], rotation = [0, 0, 0])
{
        // If not draft -> move to print position.
        if (!draft)
            translate(position)
                rotate(rotation)
                    children(0);
        else
        {
            difference()
            {
                children(0);
                // Cut-out cube
                if ($children > 1)
                    children($children-1);
            }
            // Assembly visualisation
            if ($children > 2)
                for(i=[1:$children-2])
                    color("black", 0.05)
                        children(i);
        }
}
