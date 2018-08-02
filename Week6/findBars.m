function [ibar, ilastPixel] = findBars(startPos, I)
    bar = upcaBar;
    ibar = bar;
    ilastPixel = startPos;
    for r = startPos:1:725
        if I(r) == 0
            bar.StartBarStart = r;
            for r1 = r:1:725
                if I(r1) == 1
                    bar.StartBarEnd = r1-1;
                    for r2 = r1:1:725
                        if I(r2) == 0
                            bar.EndBarStart = r2;
                            for r3 = r2:1:725
                                if I(r3) == 1
                                    bar.EndBarEnd = r3-1;
                                    ibar = bar;
                                    ilastPixel = r3;
                                    break;
                                end
                            end  
                            break;
                        end
                    end
                    break;
                end
            end
            break;
        end
    end
end